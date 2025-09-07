#!/bin/bash
set -e  

ENVIRONMENT=$1
APP_NAME="simple-web-app"
LOG_FILE="/tmp/deploy.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

if [ -z "$ENVIRONMENT" ]; then
    log "Ошибка: Не указана среда развертывания"
    log "Использование: ./deploy.sh [staging|production]"
    exit 1
fi

log "Начало развертывания приложения $APP_NAME в среду $ENVIRONMENT"

if [ "$ENVIRONMENT" = "staging" ]; then
    log "Деплой в staging среду..."
    
    if pm2 list | grep -q "$APP_NAME-staging"; then
        log "Останавливаю предыдущую версию приложения..."
        pm2 stop "$APP_NAME-staging" | tee -a $LOG_FILE
        pm2 delete "$APP_NAME-staging" | tee -a $LOG_FILE
    fi
    
    log "Запуск приложения в staging..."
    NODE_ENV=staging pm2 start app.js --name "$APP_NAME-staging" | tee -a $LOG_FILE
    
    log "Staging развертывание завершено успешно!"

elif [ "$ENVIRONMENT" = "production" ]; then
    log "Деплой в production среду..."
    
    log "Создание резервной копии..."
    tar -czf "/backups/$APP_NAME-backup-$(date +%Y%m%d-%H%M%S).tar.gz" . 2>/dev/null || true
    
    if pm2 list | grep -q "$APP_NAME-production"; then
        log "Останавливаю предыдущую версию приложения..."
        pm2 stop "$APP_NAME-production" | tee -a $LOG_FILE
        pm2 delete "$APP_NAME-production" | tee -a $LOG_FILE
    fi
    
    log "Запуск приложения в production..."
    NODE_ENV=production pm2 start app.js --name "$APP_NAME-production" | tee -a $LOG_FILE
    
    log "Production развертывание завершено успешно!"
    
else
    log "Ошибка: Неизвестная среда развертывания: $ENVIRONMENT"
    exit 1
fi

log "Проверка статуса приложения..."
pm2 list | grep "$APP_NAME-$ENVIRONMENT" | tee -a $LOG_FILE

log "Развертывание завершено!"
