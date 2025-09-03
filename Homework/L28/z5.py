class Car:
    def __init__(self, brand, model, color, year):
        self.brand = brand     # Марка автомобиля
        self.model = model     # Модель
        self.color = color     # Цвет
        self.year = year       # Год выпуска

    # Методы для получения значений (геттеры)
    def get_brand(self):
        return self.brand

    def get_model(self):
        return self.model

    def get_color(self):
        return self.color

    def get_year(self):
        return self.year

    # Методы для изменения значений (сеттеры)
    def set_brand(self, new_brand):
        self.brand = new_brand

    def set_model(self, new_model):
        self.model = new_model

    def set_color(self, new_color):
        self.color = new_color

    def set_year(self, new_year):
        if isinstance(new_year, int) and new_year > 1800:  # простая валидация
            self.year = new_year
        else:
            print("Ошибка: Некорректный год.")

    # Метод для вывода информации об автомобиле
    def display_info(self):
        print(f"Марка: {self.brand}")
        print(f"Модель: {self.model}")
        print(f"Цвет: {self.color}")
        print(f"Год выпуска: {self.year}")
        print("-" * 30)


# Создаем несколько объектов класса Car
car1 = Car("Toyota", "Corolla", "Серебристый", 2020)
car2 = Car("Ford", "Mustang", "Красный", 2022)

# Выводим информацию о машинах
print("Информация о машинах до изменений:")
car1.display_info()
car2.display_info()

# Изменяем некоторые данные через сеттеры
car1.set_color("Чёрный")
car1.set_year(2021)

car2.set_model("Focus")
car2.set_year(2020)

# Выводим обновленную информацию
print("\nИнформация о машинах после изменений:")
car1.display_info()
car2.display_info()