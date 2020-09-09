# após baixar o arquivo entre no diretorio,conceda permissão ao arquivo e execute.
# chmod +x ubuntu.sh
# ./ubuntu.sh

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
#CHAVE JENKINS
sudo cat /var/lib/jenkins/secrets/initialAdminPassword