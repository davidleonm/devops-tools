# Jenkins-Test
Jenkins-test is my first project intended to learn about some DevOps tools such as Jenkins, Sonarqube and Docker.

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
### Sonarqube
This is the application to execute code analysis. The default url and port is [http://DOCKER_HOST:9000](http://DOCKER_HOST:9000). The default credentials are *admin*/*admin*.
#### Configure non-admin credentials
Go to Administration -> Security -> Users. Create a new user for jenkins to create analysis, it must belong to sonar-users group.
#### Configure the webhook to block builds which are not compliant with quality gates
Go to Administration -> Configuration -> Webhooks. Here, you have to put an URL to your Jenkins instance in this way [http://JENKINS_INSTANCE/sonarqube-webhook](https://JENKINS_INSTANCE/sonarqube-webhook)

## Changelog
* **2.1.0** - Improved documentation to show how to put everything in place.
* **2.0.0** - Splitted Jenkins files from Python solution files.
* **1.0.0** - Updated the pipelines to deploy the solution after merging to master.
* **First release** - First release with a working suite of DevOps tools and a basic Python solution.

## License
Use this code as you wish! Totally free to be copied/pasted.