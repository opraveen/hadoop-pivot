### Steps to install hadoop-pivot tracing on AWS ###
## Pre-reqs
# sudo -s (TODO)


## X11 Forwarding
sudo apt-get -y update
sudo apt-get -y dist-upgrade
sudo apt-get -y install xfce4
sudo sed -i  's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
sudo apt-get -y install firefox gedit git vim-gnome make gcc g++

## JAVA
sudo add-apt-repository ppa:webupd8team/java # press enter
sudo apt-get -y update
# Oracle JAVA 8 License installation #
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-installer
sudo update-java-alternatives -s java-8-oracle
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

## Maven
wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxf apache-maven-3.3.9-bin.tar.gz
sudo cp -R apache-maven-3.3.9 /usr/local
sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvnDebug /usr/bin/mvnDebug
#mvn -version

## Protobuf
sudo apt-get -y remove protobuf-compiler
curl -# -LO https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
gunzip protobuf-2.5.0.tar.gz
tar -xvf protobuf-2.5.0.tar
cd protobuf-2.5.0
./configure --prefix=/usr
make
sudo make install
cd ..

# Relogin with -X option
#exit
#ssh -X -i ..

## AspectJ 
wget 'ftp://ftp.stu.edu.tw/eclipse/tools/aspectj/aspectj-1.8.9.jar'
java -jar aspectj-1.8.9.jar 
#how to bypass next->next->finish command

## ANT install
sudo apt-get -y install ant

## Environment Variables
export CLASSPATH=/root/aspectj1.8/lib/aspectjrt.jar 
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aspectj1.8/bin

## Tracing Framework
git clone https://github.com/brownsys/tracing-framework
cd tracing-framework/
mvn clean package install -DskipTests
cd ..

## Pivot Tracing with Hadoop
git clone https://github.com/brownsys/hadoop
cd hadoop/
mvn clean package install -Pdist -DskipTests -Dmaven.javadoc.skip="true"
ls hadoop-dist/target/hadoop-2.7.2/

## Environment Variables
cd hadoop-dist/target/hadoop-2.7.2/
export HADOOP_HOME=`pwd`

mkdir ~/config
cp -R etc/hadoop ~/config/
cd ~/config/hadoop/
export HADOOP_CONF_DIR=`pwd`
