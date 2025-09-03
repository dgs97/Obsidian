# Установка и настройка Zabbix Proxy с PostgreSQL на Ubuntu 24.04

Для установки zabbix-proxy вам необходимо:
- Сервер Linux (Имя : например  `zabbix_proxy_tops1257` )

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

# До сюда дошел.
## 6. Настройка конфигурации Zabbix Proxy

```bash
# Редактирование конфигурационного файла
nano /etc/zabbix/zabbix_proxy.conf
```

### Необходимые изменения в конфигурации:
```ini
Server=zabbix7.ops.by #zabbix-server
Hostname=zbx_1463 ##
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

## 9. Дополнительные настройки (опционально) ????

```bash
# Открытие порта для Zabbix Proxy в firewall (если используется)
ufw allow 10051/tcp
ufw reload

# Проверка прослушиваемых портов
ss -tlnp | grep zabbix
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
TLSPSKIdentity=PSK_ID_001 #Согласно инструкции на kb-wiki
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


# Firewall

## 1. Сначала проверим текущие настройки сети на proxy

```bash
# Проверим IP-адрес
ip addr show
hostname -I

# Проверим текущие правила iptables
sudo iptables -L -n -v
sudo iptables -t nat -L -n -v

# Проверим listening порты
sudo netstat -tlnp
sudo ss -tlnp
```

## 2. Настройка UFW (Uncomplicated Firewall) - рекомендуемый способ

```bash
# Установим UFW если нет
sudo apt install ufw -y

# Включим UFW
sudo ufw enable

# Разрешим SSH подключения (ОБЯЗАТЕЛЬНО!)
sudo ufw allow ssh
sudo ufw allow 22/tcp

# Разрешим порт для Zabbix proxy (10051)
sudo ufw allow 10051/tcp

# Разрешим порт для Zabbix агентов (10050) если proxy будет принимать данные от агентов
sudo ufw allow 10050/tcp

# Проверим статус
sudo ufw status verbose
```

## 3. Настройка с помощью iptables (продвинутый способ)

```bash
# Создадим скрипт для настройки iptables
sudo nano /etc/iptables-rules.sh
```

Добавьте содержимое в файл:
```bash
#!/bin/bash

# Очищаем существующие правила
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Политики по умолчанию
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Разрешаем loopback
iptables -A INPUT -i lo -j ACCEPT

# Разрешаем established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Разрешаем SSH (измените на ваш IP если нужно)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Разрешаем Zabbix server порт (10051)
iptables -A INPUT -p tcp --dport 10051 -j ACCEPT

# Разрешаем Zabbix agents порт (10050)
iptables -A INPUT -p tcp --dport 10050 -j ACCEPT

# Разрешаем ICMP (ping)
iptables -A INPUT -p icmp -j ACCEPT

# Логируем rejected packets
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

# Сохраняем правила
iptables-save > /etc/iptables/rules.v4
```

Сделайте скрипт исполняемым и запустите:
```bash
sudo chmod +x /etc/iptables-rules.sh
sudo /etc/iptables-rules.sh
```


## 6. Проверка firewall настроек

```bash
# Проверяем UFW
sudo ufw status

# Проверяем iptables
sudo iptables -L -n -v

# Проверяем открытые порты
sudo netstat -tlnp
sudo ss -tlnp

# Тестируем подключение с другой машины
nc -zv [IP-PROXY] 10051
telnet [IP-PROXY] 10051
```

## 7. Автоматическое применение правил при загрузке

```bash
# Для UFW правила сохраняются автоматически

# Для iptables установим persistence
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
```
