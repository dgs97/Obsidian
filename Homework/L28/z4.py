class Book:
    def __init__(self, title, author, year):
        self.title = title     # Название книги
        self.author = author   # Автор
        self.year = year       # Год издания

    # Методы для получения значений (геттеры)
    def get_title(self):
        return self.title

    def get_author(self):
        return self.author

    def get_year(self):
        return self.year

    # Методы для изменения значений (сеттеры)
    def set_title(self, new_title):
        self.title = new_title

    def set_author(self, new_author):
        self.author = new_author

    def set_year(self, new_year):
        if isinstance(new_year, int) and new_year > 0:
            self.year = new_year
        else:
            print("Ошибка: Год должен быть положительным целым числом.")

    # Метод для вывода информации о книге
    def display_info(self):
        print(f"Название: {self.title}")
        print(f"Автор: {self.author}")
        print(f"Год издания: {self.year}")
        print("-" * 30)


# Создаем объекты класса Book
book1 = Book("1984", "Джордж Оруэлл", 1949)
book2 = Book("Преступление и наказание", "Фёдор Достоевский", 1866)
book3 = Book("Мастер и Маргарита", "Михаил Булгаков", 1967)

# Вызываем методы
print("Информация о книгах до изменений:")
book1.display_info()
book2.display_info()
book3.display_info()

# Изменяем данные с помощью сеттеров
book1.set_title("Одно тысяча девятьсот восемьдесят четыре")
book1.set_year(1950)

book2.set_author("Ф. М. Достоевский")

book3.set_year(-100)  # Попытка ввести некорректный год

# Выводим обновленную информацию
print("\nИнформация о книгах после изменений:")
book1.display_info()
book2.display_info()
book3.display_info()