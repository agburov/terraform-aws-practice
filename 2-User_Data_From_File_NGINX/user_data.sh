#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h2>The page was created by the user data</h2><br>" > /var/www/html/index.html
echo "<font color="blue">Build by Terraform" >> /var/www/html/index.html
