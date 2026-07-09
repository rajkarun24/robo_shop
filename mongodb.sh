echo -e "\e[36m>>>>>>>> copying Mongo_repo <<<<<<<<\e[0m"
cp /Users/raj/Raghu_DevOps/robo_shop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>> Install MongoDB<<<<<<<<\e[0m"
dnf install mongodb-org -y

echo -e "\e[36m>>>>>>>> Changing the bidip <<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m>>>>>>>> Restart the MongoDB service  <<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod