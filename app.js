const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'Добро пожаловать в наше приложение!',
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.get('/api/greet', (req, res) => {
  const name = req.query.name || 'Гость';
  res.json({ message: `Привет, ${name}!` });
});

if (require.main === module) {
  app.listen(port, () => {
    console.log(`Приложение запущено на порту ${port}`);
    console.log(`Режим: ${process.env.NODE_ENV || 'development'}`);
  });
}

module.exports = app;
