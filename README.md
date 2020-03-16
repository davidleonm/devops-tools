# Environment-Test
Environment-Test is my first project intended to learn about some DevOps tools such as Jenkins, Sonarqube and Docker.


## Composition
* **docker-compose.yml** - Orchestator of the instance. It runs a Jenkins node in Alpine, Python slave node in Alpine and a Sonarqube. All nodes use volumes to store persistent data. Note that you would have to configure all the nodes to make them be connected, such as SSH connections, passwords, etc.
* **Dockerfile** - Docker file to build the Python Alpine node.
* **jenkins_key** - SSH private key to connect Jenkins with the slave. Please use your own file :).
* **jenkins_key.pub** - SSH Public key which is imported in the slave to allow connections from Jenkins.
* **LICENSE** - File with the license, basically it says that you can use the code as you wish.
* **README.md** - This file!
* **sshd_config** - File with configuration for SSH daemon, such as deny root connections, password authentication, change the port and some more.


## Initiate the system
To run all the instances just run:
```bash
docker-compose up --build -d
```

When you want to stop the system, just execute:
```bash
docker-compose down
```
And all the containers will be stopped and deleted.


## Configure the components involved
Once the system is initiated, there are several configurations to be performed in order to connect all the elements and start working with them.


### Generate your own ssh keys to grant access to the Jenkins Slave container
You must generate the keys, private and public, to grant access to Jenkins to the Slave container. *From the Docker host and being situated in the [environment-test](https://github.com/davidleonm/environment-test) project root folder.*
```bash
$ ssh-keygen -t ecdsa -b 521 -f jenkins_key
Generating public/private ecdsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in jenkins_key.
Your public key has been saved in jenkins_key.pub.
The key fingerprint is:
SHA256:G4M4aI2MyuTMLPb5JSK/R2yx14gNmYPTo2QtJsG+hKI
The key's randomart image is:
+---[ECDSA 521]---+
|.                |
| o               |
|o . + o          |
|o* @ @ .         |
|=.@ O X S        |
|Eo . B + =       |
|oO .o....        |
|o + o.o          |
|   =+.           |
+----[SHA256]-----+
```
The file jenkins_key.pup will be copied automatically to the Jenkins slave so in case of losing the passphrase, you have to generate the files again.


### Sonarqube
This is the application to execute code analysis. The default url and port is [http://DOCKER_HOST:9000](http://DOCKER_HOST:9000). The default credentials are *admin*/*admin*.


#### Configure non-admin credentials
Go to Administration -> Security -> Users. Create a new user for jenkins to create analysis, it must belong to sonar-users group.

#### Configure the webhook to block builds which are not compliant with quality gates
Go to Administration -> Configuration -> Webhooks. Here, you have to put an URL to your Jenkins instance in this way [http://JENKINS_INSTANCE/sonarqube-webhook](https://JENKINS_INSTANCE/sonarqube-webhook)

#### Generate a token to authenticate with the non-admin user
Log in the Sonarqube instance with the new non-admin user and go to My Account -> Security and generate a new token with a desired name.


### Jenkins
This is the application in charge of CI/CD and execute code analysis.


#### Configure admin credentials and initial configuration
To figure out the secret password, execute this command on your Docker host
```bash
docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
printed_password!
```
Select default plugins to be installed and configure a user different than admin.

#### Configure external credentials
Go to Credentials -> Global credentials.
You need to configure credentials for:
* Git repository you are using. In this example I assume you have Github.
* Secret text with the token for the Sonarqube non-admin user generated in a previous step.
* SSH with private key connection to the Slave container. Use the content of jenkins_key file as private key.
* Secret text with the ID 'github-token' in order to manage branch status from Jenkins. Keep in mind that you will need to create a token in your Github account.
* Login to Docker Hub with the ID 'docker-hub-login' to store there the images generated.

#### Install additional plugins
* SonarQube Scanner.
* docker-plugin.

#### Configure Sonarqube
Go to Administrate Jenkins -> Configure the system -> Add Sonarqube (in SonarQube servers section).
* **Name:** Sonarqube
* **URL:** URL_OF_THE_SERVER
* **Credentials:** The secret text configured for Sonarqube.

Go to Administrate Jenkins -> Global Tool Configuration. Add a new Sonarqube Scanner called 'Sonarqube'.


#### Configure Jenkins Slave
Go to Administrate Jenkins -> Administrate nodes. New node as 'Permanent agent'.
* **Name:** A desired one.
* **Executors:** 1.
* **Root folder:** /home/jenkins.
* **Labels:** slave.
* **Machine name:** jenkins-slave
* **Execution mode:** SSH
* **Credentials:** The ones configured with the private key.
* **Host key verification:** Non verifying Verification Strategy.
* **Advanced / Port:** 2233.

Once the configuration is set, the new one added should appear in the node list.


#### Configure pipeline for branches
Create a 'Multibranch Pipeline' project whose name **doesn't have spaces**.
* **Display name:** A desired one.
* **Description:** A desired one.
* **Scan Multibranch Pipeline Triggers:** Periodically if not otherwise run each 1 minute
* **Git branch source:**
    * **Project repository:** Your python-hello-world git repository.
    * **Credentials:** The ones configured with your git access.
    * **Discover branches:** Exclude 'master'. All others will be included as valid branches.
* **Build configuration:** By Jenkinsfile. As Jenkinsfile path set 'Jenkinsfile_multi_branch.groovy'.

#### Configure pipeline for master
Create a 'Pipeline' project whose name **doesn't have spaces**.
* **Description:** A desired one.
* Do not allow concurrent builds.
* **Query SCM repository:** H/5 * * * *
* **Pipeline from SCM:**
    * **Repository URL:** Your python-hello-world git repository.
    * **Credentials:** The ones configured with your git access.
    * **Branch Specifier:** master.
    * **Script Path:** Jenkinsfile_master.groovy.

#### Configure a shared library
Configure a shared library using the documentation included [here](https://github.com/davidleonm/shared-library).

## Changelog
* **2.2.1** - Fixed documentation.
* **2.2.0** - Updated Python container version.
* **2.1.0** - Improved documentation to show how to put everything in place.
* **2.0.0** - Splitted Jenkins files from Python solution files.
* **1.0.0** - Updated the pipelines to deploy the solution after merging to master.
* **First release** - First release with a working suite of DevOps tools and a basic Python solution.


## License
Use this code as you wish! Totally free to be copied/pasted.
