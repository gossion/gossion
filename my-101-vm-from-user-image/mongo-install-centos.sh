
#Modify Sudoers file to not require tty for shell script execution on CentOS
# sudo sed -i '/Defaults[[:space:]]\+requiretty/s/^/#/' /etc/sudoers

# Enable write access to the mongodb.repo and configure it for installation

#sudo chmod 777 /etc/yum.repos.d/mongodb.repo
touch /etc/yum.repos.d/mongodb.repo
echo "[mongodb-org-3.0]" >> /etc/yum.repos.d/mongodb.repo
echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb.repo
echo "baseurl=http://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.0/x86_64/" >> /etc/yum.repos.d/mongodb.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb.repo
echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo

echo `date` >>/tmp/install.log
echo "===========================startloging====================================" >> /tmp/install.log
# Install updates
yum -y update >> /tmp/install.log 2>&1

echo "===========================midloging====================================" >> /tmp/install.log
#Install Mongo DB
yum install -y mongodb-org >>/tmp/install.log 2>&1
echo "===========================endloging====================================" >> /tmp/install.log
