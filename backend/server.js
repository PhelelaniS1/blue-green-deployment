const express = require('express');
const app = express();

app.use(express.json());

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.status(200).json({ 
        status: 'OK', 
        timestamp: new Date().toISOString(),
        environment: process.env.APP_COLOR || 'unknown'
    });
});

// Simple API endpoint
app.get('/api/tasks', (req, res) => {
    res.json({ message: 'Tasks API is working!' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(Server running on port  -  environment);
});
