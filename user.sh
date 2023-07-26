log=/tmp/roboshop.log
echo -e "\e[36m >>>>>> Create user Service <<<<<<<<\e[0m"
cp user.service /etc/systemd/system/user.service &>>${log}

echo -e "\e[36m >>>>>> Create MongoDB Repo <<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[36m >>>>>>> Install NodeJS Repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e "\e[36m >>>>>>> Install NodeJS <<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e "\e[36m >>>>>>> Create Application User  <<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e "\e[36m >>>>>>> Create Application Directory <<<<<<<<\e[0m"
rm -rf /app &>>${log}

echo -e "\e[36m >>>>>>> Create Application Directory <<<<<<<<\e[0m"
mkdir /app &>>${log}

echo -e "\e[36m >>>>>>> Download Application content <<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log}

echo -e "\e[36m >>>>>>> Extract application content <<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip &>>${log}
cd /app

echo -e "\e[36m >>>>>>> Download NodeJS Dependencies <<<<<<<<\e[0m"
npm install &>>${log}

echo -e "\e[36m >>>>>>> Install Mongo Client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e "\e[36m >>>>>>> Load user schema <<<<<<<<\e[0m"
mongo --host mongodb.maheshkoheda.online </app/schema/user.js &>>${log}

echo -e "\e[36m >>>>>>> Start user service <<<<<<<<\e[0m"
systemctl daemon-reload &>>${log}
systemctl enable user &>>${log}
systemctl start user &>>${log}


