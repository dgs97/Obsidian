import os

def create_file():

    file_path = os.path.join('z2', 'test.txt')
    # Шаг 1: Создание файла и запись в него строки
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write("Это тестовый файл для домашнего задания по программированию")

    # Шаг 2: Открытие файла в режиме чтения и вывод содержимого
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    return content
