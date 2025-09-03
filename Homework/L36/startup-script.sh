#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Hello from svd-H81M-DS2V!" | sudo tee /var/www/html/index.nginx-debian.html
