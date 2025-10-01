const express = require('express');
const path = require('path');
const axios = require('axios');

const app = express();
app.use(express.static('public'));

const BACKEND_URL = process.env.BACKEND_URL || 'http://backend:3000';

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'healthy', 
    version: process.env.APP_VERSION || '1.0.0',
    service: 'frontend'
  });
});

app.get('/api/tasks', async (req, res) => {
  try {
    const response = await axios.get(\\/api/tasks\);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Backend service unavailable' });
  }
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, '0.0.0.0', () => {
  console.log(\Frontend service running on port \\);
});
