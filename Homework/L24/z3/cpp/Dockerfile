FROM ubuntu:22.04

# Обновляем систему и устанавливаем зависимости
RUN apt-get update && \
    apt-get install -y build-essential git cmake wget

# Клонируем cpp-httplib
WORKDIR /app
RUN git clone https://github.com/yhirose/cpp-httplib.git 

# Копируем наш код
COPY main.cpp .

# Компилируем с указанием пути к заголовкам
RUN g++ main.cpp -o hello_cpp -lpthread -std=c++17 -I./cpp-httplib

# Запускаем
CMD ["./hello_cpp"]
EXPOSE 8083
