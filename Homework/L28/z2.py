class BankAccount:
    def __init__(self, n, name, balance=0):
        self.n = n
        self.name = name
        self.balance = balance

    def withdraw(self, amount):
        if amount <= 0:
            print("Сумма должна быть положительной.")
            return self.balance
        if amount > self.balance:
            print("Недостаточно средств.")
            return self.balance
        self.balance -= amount
        return self.balance

    def deposit(self, amount):
        if amount <= 0:
            print("Сумма должна быть положительной.")
            return self.balance
        self.balance += amount
        return self.balance


# Создание счета
ivan = BankAccount(n=1, name="Ivan", balance=500)

print(f"Текущий баланс {ivan.name}: {ivan.withdraw(2000)}")  # попытка снять больше
print(f"Текущий баланс {ivan.name}: {ivan.deposit(200)}")   # положить деньги
print(f"Текущий баланс {ivan.name}: {ivan.withdraw(600)}")  # успешно снять