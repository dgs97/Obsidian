#!/usr/bin/env python3
import os

def ping(ip):
    ping = f"ping -c 1 {ip} > /dev/null 2>&1" #Убираем вывод команды ping
    response = os.system(ping)
    output = f"ping {ip} - {response==0}\n" #Делаем вывод типа : "ping host - True(False)"
    return output

#Окрываем файл со списком ip
with open("ip_list.txt", "r") as ip_list_txt:
    ip_list = [ip.strip() for ip in ip_list_txt]

#Открываем файл для записи
#Записываем результат ping в ping.log
with open("ping.log", "a") as log_file:
    for ip in ip_list:
        log_file.write(ping(ip))

