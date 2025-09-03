Согласно [инструкции](https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=24.04&components=server_frontend_agent_2&db=pgsql&ws=apache)
#### Install and configure Zabbix for your platform

##### a. Install Zabbix repository

```bash
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb  
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb  
apt update
```

##### b. Install Zabbix server, frontend, agent2

```bash
apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent2
```

##### c. Install Zabbix agent 2 plugins

You may want to install Zabbix agent 2 plugins.

```bash
apt install zabbix-agent2-plugin-mongodb zabbix-agent2-plugin-mssql zabbix-agent2-plugin-postgresql
```
##### d. Create initial database

```bash
# Установка PostgreSQL
apt install -y postgresql postgresql-contrib

# Проверка статуса PostgreSQL
systemctl status postgresql

# Включение автозапуска PostgreSQL
systemctl enable postgresql
```

Make sure you have database server up and running.

Run the following on your database host.

```bash
sudo -u postgres createuser --pwprompt zabbix   
sudo -u postgres createdb -O zabbix zabbix
```

On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.

```bash
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

##### e. Configure the database for Zabbix server

Edit file /etc/zabbix/zabbix_server.conf

`DBPassword=password`

##### f. Start Zabbix server and agent processes

Start Zabbix server and agent processes and make it start at system boot.

```bash
systemctl restart zabbix-server zabbix-agent2 apache2   
systemctl enable zabbix-server zabbix-agent2 apache2
```

![](screenshots/Pasted%20image%2020250831194950.png)