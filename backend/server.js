require('dotenv').config();
const express = require('express');
const { connectDB } = require('./config/db');

const app = express();

// Connect to Database
connectDB();

app.use(express.json());

const authRoutes = require('./routes/auth');
app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
