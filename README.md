# jenkins passo a passo

# Pipeline
 - Conceito de pipeline
 - Pipeline na prática

# História do jenkins
 - Jenkins como código open source
 - Importância do Jenkins

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
 - Tipos de pipelines
 - Escrita de pipelines
 - Pipeline simples 
 - Pipeline com github
 - Pipeline com paramentros
 - Pipeline com java e github

## Tipos de pipelines

## Escrita de pipelines


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

![image](/image/criandoParamentro.png)
![image](/image/nomeParamentro.png)
![image](/image/setParamentro.png)


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

# Node jenkins
- porque criar um slave

# plugins