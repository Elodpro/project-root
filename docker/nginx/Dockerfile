FROM nginx:stable-alpine 

FROM nginx:1.24
 
# Installation de SSL
RUN apt-get update && apt-get install -y \
    openssl \
    && rm -rf /var/lib/apt/lists/*
 
# Création des certificats auto-signés (dev uniquement)
RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/selfsigned.key \
    -out /etc/nginx/ssl/selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=Dev/CN=localhost"
 
 
EXPOSE 80 443