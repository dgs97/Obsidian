# Install MySQL
## Download mysql repo
```
wget https://dev.mysql.com/get/mysql-apt-config_0.8.34-1_all.deb
```

## Install gnupg
```
sudo apt install gnupg
```
## Install repo 
```
sudo dpkg -i mysql-apt-config_0.8.34-1_all.deb
```

## Update repo
```
sudo apt update
```

## Install mysql-server
```
sudo apt install mysql-server
```

## Links

[MySQL Community Downloads](https://dev.mysql.com/downloads/repo/apt/)

[A Quick Guide to Using the MySQL APT Repository](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/)