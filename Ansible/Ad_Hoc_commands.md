*Выводит инфу*:
```bash
ansible staging_servers -m setup
```

*Выполнение определенной команды shell*:
```bash
ansible all -m shell -a "uptime"
```

*command имеет урезанный функционал,может использоваться для security *:
```bash
ansible all -m command -a "uptime"
```

*Копирование на удаленные сервера, можно использовать ``-b`` для прав ``sudo`` * :
```bash
ansible all -m copy -a "src=privet.txt dest=/tmp mode=777"
```

*Удаление* :
```bash
ansible all -m file -a "path=/tmp/privet.txt state=absent"
```

Скачать на удаленные сервера:
```bash
ansible all -m get_url -a "url=https://i.imgur.com/6QbX6yA.jpeg  dest=/tmp"
```

Установка vim:
```bash
ansible all -m apt -a "name=vim state=latest" -b
```

*Удаление* vim:
```bash
ansible all -m apt -a "name=vim state=absent" -b
```

```bash
ansible all -m uri -a "url=https://svdbel.org"
```
Вывод с контентом:
```bash
ansible all -m uri -a "url=https://svdbel.org return_content=yes"
```


Installation nginx:
```bash
ansible all -m apt -a "name=nginx state=latest" -b
```


```bash
ansible all -m service -a "name=nginx state=started enabled=yes" -b
```

*Чем больше ``-v`` ,тем больше инфы:*
```bash
ansible all -m shell -a "ls /var" -vvvv
```

*Чем больше ``-v`` ,тем больше инфы:*
```bash
ansible all -m shell -a "ls /var" -vvvv
```

```bash
ansible-playbook playbook1.yml
```

```bash
ansible-playbook playbook3.yml -i hosts.txt -l PROD_SERVERS_WEB
```


ansible all -m setup