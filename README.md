# jenkins passo a passo

# História do jenkins
 - Jenkins como código open source
 - Importância do Jenkins
 
# Pipeline
 - Conceito de pipeline
 - Pipeline na prática


# Instalação

O jenkins pode ser instalado de duas formas:
- Sistema operacional
- Container docker

**Sitema Operacional - Ubuntu**

Primeiro, adicione a chave do repositório ao sistema:

```
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
```

Quando a chave for adicionada, o sistema retornará OK. Em seguida, adicione o endereço do repositório de pacotes Debian ao sources.list do servidor:

```
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
Quando ambos estiverem funcionando, execute update para que o apt use o novo repositório:
```
sudo apt update
```

Por fim, instale o Jenkins e suas dependências:
```
sudo apt install jenkins
```

Vamos iniciar o Jenkins usando o systemctl:
```
sudo systemctl start jenkins
```

Após startar é necessario configurar sua instalação, visite o Jenkins na sua porta padrão, 8080. 

No primeiro acesso e necessario digita a chave no caminho informando. Na janela do terminal, utilize o comando cat para mostrar a senha e inclui-la no jenins:

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Na tela seguinte:
- Instale os plug-ins sugeridos(install suggested plugins)
- Crie seu primeiro usuario
- Confirme a url do seu jenkins.


**Container Docker**

Inicie um container docker com o jenkins:

```
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -d jenkins/jenkins
```

Iniciado, agora vamos até o nosso browser e digitaremos http://localhost:8080 e vamos incluir a chave de acesso:

```
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Na tela seguinte:
- Instale os plug-ins sugeridos(install suggested plugins)
- Crie seu primeiro usuario
- Confirme a url do seu jenkins.

# Dashboard
![image](/image/jenkins.png)
- Jobs
- Name spaces
- Configurações geral
- Nodes
- Previsão do tempo
- Resultado de execução do job

# Pipelines


## Pipeline simples

```
node('master'){
    
    stage('Criando arquivo'){
        sh "touch jenkins.txt"
    }
    stage('Populando arquivo'){
        sh "echo jenkins na pratica > jenkins.txt"
    }
    stage('Lendo arquivo'){
        sh "cat jenkins.txt"
    }
    stage('Pasta do arquivo'){
        sh "pwd"
    }
}

```


## Pipeline com github

```
node('master'){
    
    stage('Git Clone') {
        checkout([$class: 'GitSCM', branches: [[name: '*/BRANCH']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'CREDENCIAL', url: 'URL-git']]])
    }
    stage('Executar test'){
        echo "mvn clean test"
    }
    stage('Build aplicação'){
        echo "mvn clean package"
    }
    stage('Subindo para Servidor'){
        echo "enviando arquivo"
    }
}
```

## Pipeline com paramentros

Dentro das configurações do job selecione essas opçoes:
![image](/image/parameters/criandoParamentro.png)

Após selecionar a opção **Parâmetro string** informe o _nome do parêmentro_ e o _valor padrão_. Porém o valor padrão é opcional:
![image](/image/parameters/nomeParamentro.png)

Com isso quando for executar job ele mostrara o parâmentro criado:
![image](/image/parameters/setParamentro.png)

**Codigo pipeline**
```
node('master'){
    
    stage('Git Clone') {
        checkout([$class: 'GitSCM', branches: [[name: '*/${BRANCH}']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'CREDENCIAL', url: 'URL-git']]])
    }
    stage('Executar test'){
        echo "mvn clean test"
    }
    stage('Build aplicação'){
        echo "mvn clean package"
    }
    stage('Subindo para Servidor'){
        echo "enviando arquivo"
    }
}
```


## Pipeline com github, java e maven

```
node('master'){
    
    def mvnHome = tool 'Maven3.6'
    jdk = tool 'jdk10'
    env.JAVA_HOME = "${jdk}"
    
    stage('Git Clone') {
        checkout([$class: 'GitSCM', branches: [[name: '*/BRANCH']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'CREDENCIAL', url: 'URL-git']]])
    }
    stage('Executar test'){
        echo "mvn clean test"
    }
    stage('Build aplicação'){
        echo "mvn clean package"
    }
    stage('Subindo para Servidor'){
        echo "enviando arquivo"
    }
}
```
# Credenciais
![image](/image/credentials/confJenkins.png)
![image](/image/credentials/credentials.png)
![image](/image/credentials/criandoCredentials.png)

Links de referências:

- [Install jenkins ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-18-04-pt)

- [Install jenkins docker](https://imasters.com.br/devsecops/docker-e-jenkins-para-build-de-aplicacoes)