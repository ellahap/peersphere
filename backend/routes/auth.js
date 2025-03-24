const exp = require('express');
const bc = require('bcryptjs');
const jwebt = require('jsonwebtoken');

const router = exp.Router();


const users = [];


router.post('/register', async (rq, result) => {
    const { username, password } = rq.body;
    
    if (!username || !password) {
        return result.status(400).json({ message: 'Please provide all fields' });
    }

    
    const salt = await bc.genSalt(10);
    const hashedPassword = await bc.hash(password, salt);

    const user = { username, password: hashedPassword };
    users.push(user);

    res.status(201).json({ message: 'User registered successfully', user });
});


router.post('/login', async (rq, result) => {
    const { username, password } = rq.body;
    

    const user = users.find(u => u.username === username);
    if (!user) {
        return result.status(400).json({ message: 'Invalid username or password' });
    }


    const isMatch = await bc.compare(password, user.password);
    if (!isMatch) {
        return result.status(400).json({ message: 'Invalid username or password' });
    }


    const token = jwebt.sign({ username: user.username }, process.env.JWT_SECRET, { expiresIn: '1h' });

    result.json({ message: 'Login successful', token });
});

const authMiddleWare = require('../middleware/authMiddleware');

router.get('/protected', authMiddleWare, (rq, result) => {
    result.json({ message: 'Welcome ot the protected route!', user: rq.user });
});

module.exports = router;