# Используем официальный образ Python как базовый
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . /app

# Устанавливаем зависимости
# Если у вас есть requirements.txt, раскомментируйте эту строку
# RUN pip install -r requirements.txt

# Команда для запуска приложения
CMD ["python", "app.py"]