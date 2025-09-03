# Установка и настройка Zabbix Proxy с PostgreSQL на Ubuntu 24.04

Системные требования:

| Количество узлов | CPU (ядра) | RAM (GB) | Диск (GB) |
| ---------------- | ---------- | -------- | --------- |
| **До 100**       | 1-2        | 1-2      | 10-20     |
| **100-500**      | 2-4        | 2-4      | 20-50     |
| **500-1000**     | 4-8        | 4-8      | 50-100    |
| **1000-2000**    | 8-12       | 8-16     | 100-200   |
| **2000-5000**    | 12-16      | 16-32    | 200-500   |
| **5000+**        | 16+        | 32+      | 500+      |

#### [Выберете вашу платформу](https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=24.04&components=proxy&db=pgsql&ws=)
![](screenshots/Pasted%20image%2020250825123420.png)
## 1. Установка необходимых пакетов

#### Переход в режим root:

```bash
sudo -s
```

## 2. Добавление репозитория Zabbix

```bash
# Загрузка и установка пакета репозитория Zabbix 7.0
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb

# Обновление списка пакетов
apt update
```
![](screenshots/Pasted%20image%2020250825152254.png)
![](screenshots/Pasted%20image%2020250825152151.png)
## 3. Установка Zabbix Proxy

```bash
# Установка Zabbix Proxy с поддержкой PostgreSQL
apt install zabbix-proxy-pgsql zabbix-sql-scripts
# Do you want to continue? [Y/n] y
```

![](screenshots/Pasted%20image%2020250825152508.png)
## 4. Установка и настройка PostgreSQL

```bash
# Установка PostgreSQL
apt install -y postgresql postgresql-contrib

# Проверка статуса PostgreSQL
systemctl status postgresql

# Включение автозапуска PostgreSQL
systemctl enable postgresql
```

![](screenshots/Pasted%20image%2020250825152700.png)
## 5. Создание базы данных для Zabbix Proxy

```bash
# Создание пользователя Zabbix в PostgreSQL
sudo -u postgres createuser --pwprompt zabbix
# Введите пароль при запросе и подтвердите его

# Создание базы данных для Zabbix Proxy
sudo -u postgres createdb -O zabbix zabbix_proxy

# Импорт схемы базы данных
cat /usr/share/zabbix-sql-scripts/postgresql/proxy.sql | sudo -u zabbix psql zabbix_proxy
```

![](screenshots/Pasted%20image%2020250825153057.png)

```bash
# Проверяем БД и пользователя
sudo -u postgres psql -c "\l"
```

![](screenshots/Pasted%20image%2020250825153405.png)
## 6. Настройка конфигурации Zabbix Proxy

```bash
# Редактирование конфигурационного файла
nano /etc/zabbix/zabbix_proxy.conf
```

### Необходимые изменения в конфигурации:
```ini
Server=zabbix7.ops.by #zabbix-server
Hostname=zabbix-proxy
DBName=zabbix_proxy
DBUser=zabbix
DBPassword=your_password_here  # Замените на реальный пароль
Timeout=20
```

## 7. Запуск и настройка автозапуска Zabbix Proxy

```bash
# Перезапуск службы Zabbix Proxy
systemctl restart zabbix-proxy

# Включение автозапуска при загрузке системы
systemctl enable zabbix-proxy

# Проверка статуса службы
systemctl status zabbix-proxy
```

![](screenshots/Pasted%20image%2020250825160356.png)
## 8. Проверка работы

```bash
# Проверка логов на наличие ошибок
tail -f /var/log/zabbix/zabbix_proxy.log

# Проверка подключения к базе данных
sudo -u zabbix psql -d zabbix_proxy -c "SELECT version();"
```

### Шаг 1: Генерация PSK-ключа

Выполните эти команды  на proxy для генерации пары PSK:

```bash
# Создаем директорию для ключей (если её нет)
sudo mkdir -p /etc/zabbix/tls
sudo chown zabbix:zabbix /etc/zabbix/tls
sudo chmod 700 /etc/zabbix/tls

# Генерируем PSK ключ и сохраняем в файл
sudo openssl rand -hex 32 > /etc/zabbix/tls/zabbix.psk
sudo chown zabbix:zabbix /etc/zabbix/tls/zabbix.psk
sudo chmod 600 /etc/zabbix/tls/zabbix.psk

# Смотрим содержимое файла (нам понадобится эта строка для сервера)
sudo cat /etc/zabbix/tls/zabbix.psk
```

**Запишите куда-нибудь вывод команды `cat`** — это сам ключ. Он понадобится для настройки zabbix сервера.

### Шаг 2: Настройка Zabbix proxy

Редактируем конфигурационный файл proxy.

```bash
sudo nano /etc/zabbix/zabbix_proxy.conf
```

Найдите и измените/добавьте следующие параметры:

```ini
# Включение шифрования
TLSConnect=psk

# Указываем, что для входящих соединений тоже требуется PSK (если сервер будет соединяться с proxy)
TLSAccept=psk

# Путь к файлу с PSK-ключом
TLSPSKFile=/etc/zabbix/tls/zabbix.psk

# Идентификатор PSK (произвольная строка, но должна совпадать на сервере и на proxy)
TLSPSKIdentity=PSK_ID_001
```

**Сохраните файл и перезапустите proxy.**

```bash
sudo systemctl restart zabbix-proxy
```

```bash
sudo tail -f /var/log/zabbix/zabbix_proxy.log
```


Возможные проблемы :

![](screenshots/Pasted%20image%2020250825224320.png)

```bash
sudo nano /etc/zabbix/zabbix_proxy.conf
```

```bash
FpingLocation=/usr/sbin/fping 
#FpingLocation=/usr/bin/fping

Fping6Location=/usr/sbin/fping6 
#Fping6Location=/usr/bin/fping6
```

```bash
sudo systemctl restart zabbix-proxy
```
