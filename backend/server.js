const express = require('express');
const mongoose = require('mongoose');
const redis = require('redis');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect('mongodb://mongodb:27017/taskmanager', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// Connect to Redis
const redisClient = redis.createClient({
  url: 'redis://redis:6379'
});
redisClient.connect();

// Task model
const TaskSchema = new mongoose.Schema({
  title: String,
  description: String,
  completed: Boolean
});
const Task = mongoose.model('Task', TaskSchema);

// Routes
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'healthy', 
    version: process.env.APP_VERSION || '1.0.0',
    service: 'backend'
  });
});

app.get('/api/tasks', async (req, res) => {
  try {
    const cacheKey = 'all_tasks';
    const cached = await redisClient.get(cacheKey);
    
    if (cached) {
      return res.json(JSON.parse(cached));
    }
    
    const tasks = await Task.find();
    await redisClient.setEx(cacheKey, 30, JSON.stringify(tasks));
    res.json(tasks);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/tasks', async (req, res) => {
  try {
    const task = new Task(req.body);
    await task.save();
    await redisClient.del('all_tasks');
    res.status(201).json(task);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(\Backend service running on port \\);
});
