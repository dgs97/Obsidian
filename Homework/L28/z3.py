class Student:
    def __init__(self, name, age, grades):
        self.name = name      # Имя студента
        self.age = age        # Возраст
        self.grades = grades  # Список оценок

    def average_grade(self):
        """Метод для вычисления среднего балла"""
        if len(self.grades) == 0:
            return 0  # Чтобы избежать ошибки при пустом списке
        return sum(self.grades) / len(self.grades)

    def student_status(self):
        """Метод для определения статуса студента"""
        avg = self.average_grade()
        if avg >= 4.5:
            return "Отличник"
        elif avg >= 3.5:
            return "Хорошист"
        elif avg >= 2.5:
            return "Троечник"
        else:
            return "Двоечник"


# Создаем объекты
s1 = Student("Анна", 20, [5, 5, 5, 5])
s2 = Student("Борис", 19, [4, 4, 5, 4])

# Выводим информацию
print(f"{s1.name} : {s1.student_status()}")
print(f"{s2.name} : {s2.student_status()}")