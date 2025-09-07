const request = require('supertest');
const app = require('../app');

describe('Тесты приложения', () => {
  test('GET / возвращает приветствие', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.body.message).toContain('Добро пожаловать');
  });

  test('GET /health возвращает статус OK', async () => {
    const response = await request(app).get('/health');
    expect(response.statusCode).toBe(200);
    expect(response.body.status).toBe('OK');
  });

  test('GET /api/greet возвращает персонализированное приветствие', async () => {
    const response = await request(app).get('/api/greet?name=Иван');
    expect(response.statusCode).toBe(200);
    expect(response.body.message).toBe('Привет, Иван!');
  });
});
