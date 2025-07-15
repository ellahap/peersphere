require('dotenv').config(); // Add this line FIRST

const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const multer = require('multer');
const fs = require('fs');
const { Pool } = require('pg');

const app = express();
const PORT = 3000;


const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});


const users = {
  'testuser': 'password123',
  'admin': 'adminpass'
};

// upload
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

app.use(express.static(path.join(__dirname, 'public')));
app.use('/download', express.static(uploadDir));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: true
}));

function isAuthenticated(req, res, next) {
  if (req.session.user) {
    next();
  } else {
    res.redirect('/');
  }
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const timestamp = Date.now();
    const ext = path.extname(file.originalname);
    const base = path.basename(file.originalname, ext);
    cb(null, `${base}_${timestamp}${ext}`);
  }
});

const allowedTypes = ['.pdf', '.ppt', '.pptx', '.docx', '.txt', '.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    if (allowedTypes.includes(ext)) {
      cb(null, true);
    } else {
      cb(new Error('Only PDF, PPT, DOCX, and TXT files are allowed'));
    }
  }
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login_page.html'));
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'landing_page.html'));
});

app.post('/login', async (req, res) => {
  const { uname, psw } = req.body;
  try {
    const result = await pool.query(
      'SELECT * FROM users WHERE username = $1 AND password = $2',
      [uname, psw]
    );
    if (result.rows.length > 0) {
      req.session.user = uname;
      res.redirect('/main');
    } else {
      res.send('<h2>Login failed. <a href="/">Try again</a></h2>');
    }
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).send('Server error');
  }
});

app.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

app.get('/main', isAuthenticated, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'main_page.html'));
});

app.get('/qa', isAuthenticated, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'Q&A_page.html'));
});

app.get('/schedule', isAuthenticated, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'scheduling.html'));
});

app.get('/signup', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'signup_page.html'));
});

app.get('/api/group/:id', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT name FROM study_groups WHERE id = $1',
      [req.params.id]
    );
    if (result.rows.length > 0) {
      res.json({ name: result.rows[0].name });
    } else {
      res.status(404).json({ error: 'Group not found' });
    }
  } catch (err) {
    console.error('Group name error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/resources/:groupId', isAuthenticated, async (req, res) => {
  const { groupId } = req.params;

  try {
    const result = await pool.query(
      `SELECT r.id, r.uploaded_by, u.username AS uploader_name, r.title, r.file_name, r.content_type, r.likes, r.hearts, r.uploaded_at
       FROM resources r
       JOIN users u ON r.uploaded_by = u.id
       WHERE r.group_id = $1
       ORDER BY r.uploaded_at DESC`,
      [groupId]
    );

    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Fetch resources error:', err);
    res.status(500).json({ error: 'Failed to fetch resources' });
  }
});



app.post('/signup', async (req, res) => {
  const { uname, psw } = req.body;
  try {
    const exists = await pool.query('SELECT * FROM users WHERE username = $1', [uname]);
    if (exists.rows.length > 0) {
      res.send('<h2>Username already exists. <a href="/signup">Try again</a></h2>');
    } else {
      await pool.query('INSERT INTO users (username, password) VALUES ($1, $2)', [uname, psw]);
      req.session.user = uname;
      res.redirect('/main');
    }
  } catch (err) {
    console.error('Signup error:', err);
    res.status(500).send('Server error');
  }
});

app.post('/api/groups', async (req, res) => {
  const { name, join_code } = req.body;
  const userId = req.session.userId;

  try {
    const groupResult = await pool.query(
      'INSERT INTO study_groups (name, join_code) VALUES ($1, $2) RETURNING id',
      [name, join_code]
    );
    const groupId = groupResult.rows[0].id;

    await pool.query(
      'INSERT INTO memberships (user_id, group_id) VALUES ($1, $2)',
      [userId, groupId]
    );

    res.json({ id: groupId, name, join_code });
  } catch (err) {
    console.error('Create group error:', err);
    res.status(500).json({ error: 'Failed to create group' });
  }
});

app.post('/api/join', async (req, res) => {
  const { join_code } = req.body;
  const userId = req.session.userId;

  try {
    const result = await pool.query(
      'SELECT id, name FROM study_groups WHERE join_code = $1',
      [join_code]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Group not found' });
    }

    const group = result.rows[0];
    await pool.query(
      'INSERT INTO memberships (user_id, group_id) VALUES ($1, $2) ON CONFLICT DO NOTHING',
      [userId, group.id]
    );

    res.json(group);
  } catch (err) {
    console.error('Join group error:', err);
    res.status(500).json({ error: 'Failed to join group' });
  }
});



app.use(async (req, res, next) => {
  if (req.session.user) {
    const result = await pool.query('SELECT id FROM users WHERE username = $1', [req.session.user]);
    if (result.rows.length > 0) {
      req.session.userId = result.rows[0].id;
    }
  }
  next();
});

app.get('/api/groups', async (req, res) => {
  const userId = req.session.userId;

  try {
    const result = await pool.query(
      `SELECT g.id, g.name, g.join_code
       FROM memberships m
       JOIN study_groups g ON m.group_id = g.id
       WHERE m.user_id = $1`,
      [userId]
    );

    res.json(result.rows);
  } catch (err) {
    console.error('Fetch groups error:', err);
    res.status(500).json({ error: 'Failed to fetch groups' });
  }
});



app.post('/upload', isAuthenticated, upload.single('file'), async (req, res) => {
  try {
    const { originalname, filename } = req.file;
    const { groupId, title, contentType } = req.body;
    const userId = req.session.userId;

    if (!groupId || !title || !contentType) {
      return res.status(400).json({ error: 'Missing required fields.' });
    }

    const result = await pool.query(
      `INSERT INTO resources (group_id, uploaded_by, title, file_name, content_type, likes, hearts, uploaded_at)
       VALUES ($1, $2, $3, $4, $5, 0, 0, NOW())
       RETURNING id`,
      [groupId, userId, title, filename, contentType]
    );

    res.status(200).json({ 
      message: 'File uploaded and saved to database successfully',
      filename: filename,
      resourceId: result.rows[0].id
    });
  } catch (err) {
    console.error('Upload error:', err);
    res.status(500).json({ error: 'Failed to upload and save resource' });
  }
});


app.get('/download/:filename', isAuthenticated, (req, res) => {
  const filePath = path.join(uploadDir, req.params.filename);
  if (fs.existsSync(filePath)) {
    console.log(`${req.session.user} downloaded: ${req.params.filename}`);
    res.download(filePath);
  } else {
    res.status(404).send('File not found');
  }
});

// Get all threads for a group
app.get('/api/questions/:groupId', async (req, res) => {
  const { groupId } = req.params;
  try {
    const result = await pool.query(
      `SELECT t.id, t.title, u.username AS creator, t.created_at
       FROM threads t
       JOIN users u ON t.created_by = u.id
       WHERE t.group_id = $1
       ORDER BY t.created_at DESC`,
      [groupId]
    );
    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Fetch questions error:', err);
    res.status(500).json({ error: 'Failed to fetch questions' });
  }
});

// Get all answers for a thread
app.get('/api/answers/:threadId', async (req, res) => {
  const { threadId } = req.params;
  const userId = req.session.userId || null;
  try {
    const result = await pool.query(
      `SELECT a.id, a.content, u.username AS creator, a.votes, a.created_at,
              COALESCE(v.vote_type, 0) AS user_vote
       FROM answers a
       JOIN users u ON a.created_by = u.id
       LEFT JOIN votes v ON v.answer_id = a.id AND v.user_id = $1
       WHERE a.thread_id = $2
       ORDER BY a.created_at ASC`,
      [userId, threadId]
    );
    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Fetch answers error:', err);
    res.status(500).json({ error: 'Failed to fetch answers' });
  }
});


// Post a new question
app.post('/api/questions', isAuthenticated, async (req, res) => {
  const { groupId, title } = req.body;
  const userId = req.session.userId;
  try {
    await pool.query(
      `INSERT INTO threads (group_id, title, created_by)
       VALUES ($1, $2, $3)`,
      [groupId, title, userId]
    );
    res.status(200).json({ message: 'Question posted!' });
  } catch (err) {
    console.error('Thread post error:', err);
    res.status(500).json({ error: 'Failed to post question' });
  }
});

// Post a new answer
app.post('/api/answers', isAuthenticated, async (req, res) => {
  const { threadId, content } = req.body;
  const userId = req.session.userId;
  try {
    await pool.query(
      `INSERT INTO answers (thread_id, content, created_by)
       VALUES ($1, $2, $3)`,
      [threadId, content, userId]
    );
    res.status(200).json({ message: 'Answer posted!' });
  } catch (err) {
    console.error('Answer post error:', err);
    res.status(500).json({ error: 'Failed to post answer' });
  }
});

// Upvote/Downvote an answer (user can vote only once, toggle behavior)
app.post('/api/answers/:id/vote', isAuthenticated, async (req, res) => {
  const { id } = req.params;  // answer ID
  const { delta } = req.body; // +1 for upvote, -1 for downvote
  const userId = req.session.userId;

  if (![1, -1].includes(delta)) {
    return res.status(400).json({ error: 'Invalid vote delta.' });
  }

  try {
    // Check if user already voted
    const voteResult = await pool.query(
      'SELECT vote_type FROM votes WHERE answer_id = $1 AND user_id = $2',
      [id, userId]
    );

    if (voteResult.rows.length > 0) {
      const existingVote = voteResult.rows[0].vote_type;

      if (existingVote === delta) {
        // User clicked again to REMOVE their vote
        await pool.query('DELETE FROM votes WHERE answer_id = $1 AND user_id = $2', [id, userId]);
        await pool.query('UPDATE answers SET votes = votes - $1 WHERE id = $2', [delta, id]);
      } else {
        // User switched from upvote <-> downvote
        await pool.query('UPDATE votes SET vote_type = $1 WHERE answer_id = $2 AND user_id = $3', [delta, id, userId]);
        await pool.query('UPDATE answers SET votes = votes + $1 * 2 WHERE id = $2', [delta, id]);
        // multiply by 2 because you're reversing previous vote
      }
    } else {
      // First time voting
      await pool.query('INSERT INTO votes (answer_id, user_id, vote_type) VALUES ($1, $2, $3)', [id, userId, delta]);
      await pool.query('UPDATE answers SET votes = votes + $1 WHERE id = $2', [delta, id]);
    }

    res.status(200).json({ message: 'Vote registered.' });
  } catch (err) {
    console.error('Vote error:', err);
    res.status(500).json({ error: 'Failed to register vote.' });
  }
});

// Save user availability
app.post('/api/availabilities', isAuthenticated, async (req, res) => {
  const { groupId, username, color, slots } = req.body; // slots: [{day, hour}, ...]

  try {
    const client = await pool.connect();
    try {
      await client.query('BEGIN');

      // Delete old availabilities for this user in this group
      await client.query(
        `DELETE FROM availabilities WHERE group_id = $1 AND username = $2`,
        [groupId, username]
      );

      // Insert all new availability slots
      const insertPromises = slots.map(slot => {
        return client.query(
          `INSERT INTO availabilities (group_id, username, day, hour, color)
           VALUES ($1, $2, $3, $4, $5)`,
          [groupId, username, slot.day, slot.hour, color]
        );
      });

      await Promise.all(insertPromises);

      await client.query('COMMIT');
      res.status(200).json({ message: 'Availability saved!' });
    } catch (err) {
      await client.query('ROLLBACK');
      console.error('Availability save error:', err);
      res.status(500).json({ error: 'Failed to save availability' });
    } finally {
      client.release();
    }
  } catch (err) {
    console.error('Database connection error:', err);
    res.status(500).json({ error: 'Database connection error' });
  }
});

app.get('/api/availabilities/:groupId', async (req, res) => {
  const { groupId } = req.params;

  try {
      const result = await pool.query(
          `SELECT DISTINCT username, color FROM availabilities WHERE group_id = $1`,
          [groupId]
      );

      const slotsResult = await pool.query(
          `SELECT username, day, hour, color FROM availabilities WHERE group_id = $1`,
          [groupId]
      );

      res.json({
          users: result.rows, // list of users and their colors
          slots: slotsResult.rows // list of availabilities
      });
  } catch (err) {
      console.error('Error loading availabilities:', err);
      res.status(500).json({ error: 'Failed to load availabilities' });
  }
});



app.post('/api/availabilities/bulk', async (req, res) => {
  const { groupId, users } = req.body;

  try {
      for (const user of users) {
          const { username, color, slots } = user;
          for (const slot of slots) {
              const { day, hour } = slot;

              await pool.query(
                  `INSERT INTO availabilities (group_id, username, day, hour, color)
                   VALUES ($1, $2, $3, $4, $5)
                   ON CONFLICT DO NOTHING`,
                  [groupId, username, day, hour, color]
              );
          }
      }

      res.json({ success: true });
  } catch (err) {
      console.error('Bulk save error:', err);
      res.status(500).json({ success: false });
  }
});





app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

app.post('/api/resources/:id/react', isAuthenticated, async (req, res) => {
  const { id } = req.params;
  const { type } = req.body;

  if (!['likes', 'hearts'].includes(type)) {
    return res.status(400).json({ error: 'Invalid reaction type.' });
  }

  try {
    await pool.query(
      `UPDATE resources
       SET ${type} = ${type} + 1
       WHERE id = $1`,
      [id]
    );

    res.status(200).json({ message: 'Reaction registered.' });
  } catch (err) {
    console.error('React error:', err);
    res.status(500).json({ error: 'Failed to register reaction.' });
  }
});

