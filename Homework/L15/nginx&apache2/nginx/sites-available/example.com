server {
    listen 80;
    server_name example.com www.example.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Статика (если нужно отдавать через Nginx)
    location ~ \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {
        root /var/www/html;
        expires 30d;
    }
}
