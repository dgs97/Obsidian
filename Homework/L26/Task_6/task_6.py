#!/usr/bin/env python3
import sys

def find_files_with_substring(files, substring):
    matches = [file for file in files if substring in file]
    return matches

substring = sys.argv[1] #искомая подстрока
files = sys.argv[2:] #список имён файлов для проверки
result = find_files_with_substring(files, substring)

if result:
    print(f"Найденные файлы с подстрокой '{substring}':")
    for file in result:
        print(f" - {file}")
else:
    print(f"Файлы с подстрокой '{substring}' не найдены.")