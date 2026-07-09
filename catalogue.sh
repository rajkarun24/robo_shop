echo -e "\e[36m>>>>>>>> copying catalogue service <<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>> copying mongo repo <<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>>> Install NodeJS <<<<<<<<\e[0m"
dnf install nodejs -y

echo -e  "\e[36m>>>>>>>> Add application User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>> Download the application code to created app dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>>> Download dependencies <<<<<<<<\e[0m"
cd \app
npm install

echo -e "\e[36m>>>>>>>> Load and start the catalogue service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[36m>>>>>>>> Install MongoDB Client <<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>> Load the Schema <<<<<<<<\e[0m"
mongo --host mongodb.rajkarun0606.online </app/schema/catalogue.js