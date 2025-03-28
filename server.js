const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');

const app = express();
const PORT = 3000;

// Dummy user database
const users = {
  'testuser': 'password123',
  'admin': 'adminpass'
};

// Middleware
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: true
}));

// Middleware to check login
function isAuthenticated(req, res, next) {
  if (req.session.user) {
    next();
  } else {
    res.redirect('/');
  }
}

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login_page.html'));
});

app.post('/login', (req, res) => {
  const { uname, psw } = req.body;
  if (users[uname] === psw) {
    req.session.user = uname;
    res.redirect('/main');
  } else {
    res.send('<h2>Login failed. <a href="/">Try again</a></h2>');
  }
});

app.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

// Protected routes
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

app.post('/signup', (req, res) => {
  const { uname, psw } = req.body;

  if (users[uname]) {
    res.send('<h2>Username already exists. <a href="/signup">Try again</a></h2>');
  } else {
    users[uname] = psw;
    req.session.user = uname;
    res.redirect('/main');
  }
});


// Start the server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
