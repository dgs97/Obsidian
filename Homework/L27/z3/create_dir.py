import os

def create_dir():

    target_dir = os.path.join('z3', 'mydir')
    
    # 1. Создаем директорию 'mydir', если она не существует
   
    os.makedirs(target_dir, exist_ok=True)

    # 2. Переходим в созданную директорию
    os.chdir(target_dir)
    
    # 3. Создаем три пустых файла
    for i in range(1, 4):
        with open(f'file{i}.txt', 'w') as f:
            pass  # просто создаём пустой файл

    # 4. Выводим список файлов в текущей директории
    return os.listdir()
