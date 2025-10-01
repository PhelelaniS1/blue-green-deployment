const express = require('express');
const app = express();

app.use(express.json());

// Health check endpoint (required for Kubernetes)
app.get('/api/health', (req, res) => {
    res.status(200).json({ 
        status: 'OK', 
        timestamp: new Date().toISOString(),
        environment: process.env.APP_COLOR || 'unknown',
        version: '1.0.0'
    });
});

// Simple API endpoints
app.get('/api/tasks', (req, res) => {
    res.json({ 
        message: 'Tasks API is working!',
        environment: process.env.APP_COLOR || 'unknown',
        data: []
    });
});

app.get('/api/info', (req, res) => {
    res.json({
        name: 'Task Manager API',
        version: '1.0.0',
        environment: process.env.APP_COLOR || 'unknown'
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(\✅ Server running on port \ - \ environment\);
});
