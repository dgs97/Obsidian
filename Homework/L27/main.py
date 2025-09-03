from z1.multiply_numbers import multiply_numbers
from z2.create_file import create_file
from z3.create_dir import create_dir
from z4.jinja_tst import jinja
# Задание 1
print(f"Задание 1: {multiply_numbers(3,4)}\n")

# Задание 2
print(f"Задание 2: {create_file()}\n")

# Задание 3
print(f"Задание 3: {create_dir()}\n")

# Задание 4
users = [
      {'name': 'Алексей', 'email': 'alex@example.com'},
      {'name': 'Мария', 'email': 'maria@example.com'},
      {'name': 'Иван', 'email': 'ivan@example.com'}
  ]
print(f"Задание 4: \n{jinja(users)}")
