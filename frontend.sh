echo -e "\e[36m>>>>>>>> Install Ngnix <<<<<<<<\e[0m"
dnf install nginx -y

echo -e "\e[36m>>>>>>>> copying roboshop_conf <<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

rm -rf /usr/share/nginx/html/*

echo -e "\e[36m>>>>>>>> Download the frontend content <<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m>>>>>>>> Extracting frontend content <<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>> Restart Nginx Service <<<<<<<<\e[0m"
systemctl restart nginx
systemctl enable nginx