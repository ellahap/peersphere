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
  user: 'ellahappel',
  host: 'localhost',
  database: 'peersphere',
  password: 'peersphere2025',
  port: 5432,
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

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login_page.html'));
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

app.post('/api/questions', async (req, res) => {
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
    console.error('Thread error:', err);
    res.status(500).json({ error: 'Failed to post question' });
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



app.post('/upload', isAuthenticated, upload.single('file'), (req, res) => {
  res.status(200).json({ message: 'File uploaded successfully', filename: req.file.filename });
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

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
