echo -e "\e[36m>>>>>>>> copying catalogue service <<<<<<<<\e[0"
cp /Users/raj/Raghu_DevOps/robo_shop/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>> copying mongo repo <<<<<<<<\e[0"
cp /Users/raj/Raghu_DevOps/robo_shop/mongo.repo /etc/yum.repos.d/mongo.repo

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>>> Install NodeJS <<<<<<<<\e[0"
dnf install nodejs -y

echo -e  "\e[36m>>>>>>>> Add application User <<<<<<<<\e[0"
useradd roboshop

echo -e "\e[36m>>>>>>>> Download the application code to created app dir <<<<<<<<\e[0"
rm -rf /app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>>> Download dependencies <<<<<<<<\e[0"
cd \app
npm install

echo -e "\e[36m>>>>>>>> Load and start the catalogue service <<<<<<<<\e[0"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[36m>>>>>>>> Install MongoDB Client <<<<<<<<\e[0"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>> Load the Schema <<<<<<<<\e[0"
mongo --host mongodb.rajkarun0606.online </app/schema/catalogue.js