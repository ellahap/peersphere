const { Client } = require('pg');
require('dotenv').config();

const client = new Client({
    connectionString: process.env.PG_URI
});

const connectDB = async () => {
    try {
        await client.connect();
        console.log('PostgreSQL Connected Successfully');
    } catch (error) {
        console.error(`Error: ${error.message}`);
        process.exit(1);
    }
};

module.exports = { client, connectDB };