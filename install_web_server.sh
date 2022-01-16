#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
echo "<h1>Hello world</h1>" | sudo tee /var/www/html/index.nginx-debian.html