# Шаг 2: Указываем базовый образ
FROM ubuntu:20.04

# Шаг 3: Обновляем систему и устанавливаем зависимости
RUN apt-get update && \
    apt-get install -y nginx curl

# Создаем каталог для статики
RUN mkdir -p /app/static

# Шаг 4: Копируем конфигурацию NGINX из текущего каталога в контейнер
COPY nginx.conf /etc/nginx/nginx.conf

# Шаг 5: Копируем статические файлы в контейнер
COPY app/static/ /app/static/

# Шаг 6: Открываем порт 8080
EXPOSE 8080

# Шаг 7: Запускаем NGINX при старте контейнера
CMD ["nginx", "-g", "daemon off;"]
