const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');

const multer = require('multer');

// Configure storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Save files in /uploads folder
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); // Keep original file name
  }
});

const upload = multer({ storage: storage });

// Make sure uploads folder exists
const fs = require('fs');
if (!fs.existsSync('uploads')) {
  fs.mkdirSync('uploads');
}


const app = express();
const PORT = 3000;

const { Pool } = require('pg');

const pool = new Pool({
  user: 'ellahappel',
  host: 'localhost',
  database: 'peersphere',
  password: 'peersphere2025',
  port: 5432, // default PostgreSQL port
});


const users = {
  'testuser': 'password123',
  'admin': 'adminpass'
};

app.use(express.static(path.join(__dirname, 'public')));
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

app.get('/download/:filename', (req, res) => {
  const filePath = path.join(__dirname, 'uploads', req.params.filename);
  res.download(filePath, err => {
    if (err) {
      console.error('Download error:', err);
      res.status(404).send('File not found');
    }
  });
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

app.post('/upload', upload.single('file'), (req, res) => {
  if (!req.file) {
    console.log("⚠️ No file uploaded");
    return res.status(400).json({ success: false, error: 'No file uploaded' });
  }

  console.log("✅ File uploaded:", req.file.originalname);

  res.json({
    success: true,
    filename: req.file.originalname
  });
});






app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
