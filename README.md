# Простое nodejs приложение

Простое Express.js приложение для запуска с помощью Jenkins, но БЕЗ docker

## Установка
```bash
npm install
```
## Запуск
```bash
npm start
```
## Тестирование
```bash
npm test
```
## Развертывание
### Staging
```bash
./deploy.sh staging
```
### Production
```bash
./deploy.sh production
```

#### Дополнительные настройки для Jenkins:
1. На сервере установлены:
   - Node.js и npm
   - PM2 для управления процессами Node.js
   - Jest для тестирования

2. Скрипт deploy.sh исполняемый
