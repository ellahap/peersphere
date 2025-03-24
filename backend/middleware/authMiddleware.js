const jwebt = require('jsonwebtoken');

module.exports = function (rq, result, next) {
    const token = rq.header('Authorization');
    
    if (!token) {
        return result.status(401).json({ message: 'Access denied. No token provided' });
    }

    try {
        const decoded = jwebt.verify(token, process.env.JWT_SECRET);
        rq.user = decoded;
        next();
    } catch (error) {
        result.status(400).json({ message: 'Invalid token' });
    }
};