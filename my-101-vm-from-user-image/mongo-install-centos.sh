
#Modify Sudoers file to not require tty for shell script execution on CentOS
# sudo sed -i '/Defaults[[:space:]]\+requiretty/s/^/#/' /etc/sudoers

# Enable write access to the mongodb.repo and configure it for installation

#sudo chmod 777 /etc/yum.repos.d/mongodb.repo
start_at=`date | cut -d ' ' -f4`
touch /etc/yum.repos.d/mongodb.repo
echo "[mongodb-org-3.0]" >> /etc/yum.repos.d/mongodb.repo
echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb.repo
echo "baseurl=http://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.0/x86_64/" >> /etc/yum.repos.d/mongodb.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb.repo
echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo

echo `date` >>/tmp/install.log
echo "===========================startloging====================================" >> /tmp/install.log
#Install Mongo DB
yum install -y mongodb-org >>/tmp/install.log 2>&1
status1=$?
yum install -y gcc 
status2=$?
yum install -y gnome-desktop
status3=$?
yum install -y eclipse
status4=$?
yum install -y mysql
status5=$?
echo "===========================midloging====================================" >> /tmp/install.log
hostname=`hostname`
status=$status1$status2$status3$status4$status5
complete_at=`date | cut -d ' ' -f4`
duration="${start_at}To${complete_at}"

ipstr=`ifconfig`
ip=`echo ${ipstr#*addr:}|cut -d ' ' -f1`

url="http://guwe-u1404.southeastasia.cloudapp.azure.com/stress/${hostname//-/_}/$status/${duration//:/_}/${ip//./_}/"
echo "curl $url" >>/tmp/install.log 2>&1
curl $url

echo "===========================endloging====================================" >> /tmp/install.log
