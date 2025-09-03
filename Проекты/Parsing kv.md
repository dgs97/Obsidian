Создаем тачку 

```bash
gcloud compute instances create vm-cheap \
  --zone=us-central1-a \
  --machine-type=e2-micro \
  --image-family=debian-12 \
  --image-project=debian-cloud \
  --boot-disk-size=10GB \
  --boot-disk-type=pd-standard \
  --tags=http-server \
  --metadata=enable-oslogin=true
```

```bash
gcloud config set project development-465907
```

```bash
gcloud compute ssh vm-cheap --zone=us-central1-a
```


Отлично! Давайте напишем простой Python-скрипт, который будет парсить новые объявления с **Kufar.by** по вашей ссылке и отправлять уведомления в **Telegram**.  

### **Что нам понадобится?**
1. **Python 3.8+** (установите с [оф. сайта](https://www.python.org/))
2. **Библиотеки:** `requests`, `beautifulsoup4`, `python-telegram-bot`  
3. **Telegram-бот** (создаём через [@BotFather](https://t.me/BotFather))  

---

## **1. Создаём Telegram-бота**
1. Откройте Telegram, найдите **@BotFather**.  
2. Напишите `/newbot` и следуйте инструкциям.  
3. Получите **API-токен** (выглядит примерно так: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`).  

---

## **2. Устанавливаем библиотеки**

```bash
   sudo apt update
   python3 -m venv myenv
   source myenv/bin/activate
   pip install pipx
   pip install pipx requests beautifulsoup4 python-telegram-bot

```

Откройте терминал (CMD/PowerShell) и выполните:  
```bash
sudo apt install python3-pip -y
```

```bash
pip install requests beautifulsoup4 python-telegram-bot
```

---

## **3. Пишем скрипт**
Создайте файл `kufar_monitor.py` и вставьте код:  

```python
import requests
from bs4 import BeautifulSoup
import time
from telegram import Bot
from telegram.error import TelegramError

# Настройки
TELEGRAM_BOT_TOKEN = "ВАШ_ТОКЕН_БОТА"  # Замените на свой токен
TELEGRAM_CHAT_ID = "ВАШ_CHAT_ID"      # Ваш ID в Telegram (можно узнать у @userinfobot)
KUFA_URL = "https://re.kufar.by/l/minsk/snyat/kvartiru/bez-posrednikov?cur=BYR&prc=r%3A0%2C120000"

# Функция для отправки сообщения в Telegram
def send_telegram_notification(bot, message):
    try:
        bot.send_message(chat_id=TELEGRAM_CHAT_ID, text=message)
    except TelegramError as e:
        print(f"Ошибка отправки в Telegram: {e}")

# Функция для парсинга Kufar
def parse_kufar():
    try:
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        }
        response = requests.get(KUFA_URL, headers=headers)
        response.raise_for_status()  # Проверка на ошибки HTTP

        soup = BeautifulSoup(response.text, 'html.parser')
        ads = soup.find_all('article', class_='kf-jr5kf')  # Класс может измениться!

        new_ads = []  # Здесь будем хранить новые объявления
        for ad in ads:
            title = ad.find('h3').text.strip() if ad.find('h3') else "Без названия"
            price = ad.find('span', class_='kf-j7qwj').text.strip() if ad.find('span', class_='kf-j7qwj') else "Цена не указана"
            link = ad.find('a')['href'] if ad.find('a') else "#"
            
            ad_info = f"🏠 **{title}**\n💰 {price}\n🔗 [Ссылка](https://kufar.by{link})"
            new_ads.append(ad_info)

        return new_ads

    except Exception as e:
        print(f"Ошибка парсинга: {e}")
        return []

# Основной цикл
def main():
    bot = Bot(token=TELEGRAM_BOT_TOKEN)
    last_ads = set()  # Чтобы не дублировать уведомления

    while True:
        print("Проверяю новые объявления...")
        current_ads = parse_kufar()

        for ad in current_ads:
            if ad not in last_ads:
                send_telegram_notification(bot, ad)
                last_ads.add(ad)

        time.sleep(300)  # Проверка каждые 5 минут

if __name__ == "__main__":
    main()
```

---

## **4. Запуск скрипта**
1. Сохраните файл `kufar_monitor.py`.  
2. Запустите в терминале:  
   ```bash
   python kufar_monitor.py
   ```
3. Бот начнёт присылать уведомления о новых объявлениях.  

---

### **Что можно улучшить?**
✅ **Сохранять объявления в файл** (чтобы после перезапуска скрипта не дублировались).  
✅ **Добавить фильтры** (например, исключать определённые слова в заголовке).  
✅ **Задеплоить на сервер** (чтобы скрипт работал 24/7).  

Если Kufar блокирует парсинг, можно попробовать **Selenium** (автоматизированный браузер).  

Нужна доработка под ваш случай? Готов помочь! 🚀



— Управление серверами на базе Linux (Ubuntu, CentOS, Debian и др.)

2. **Network Configuration & Troubleshooting**  
    — Настройка и диагностика сетей (TCP/IP, DNS, DHCP, VLAN, Firewall)
    
3. **Automation & Scripting (Bash, Python, PowerShell)**  
    — Автоматизация задач через скрипты и инструменты
    
4. **Monitoring & Alerting (Zabbix, Prometheus, Grafana)**  
    — Настройка мониторинга, алертов и дашбордов
    
5. **Backup, Recovery & Security Management**  
    — Резервное копирование, восстановление данных и обеспечение безопасности