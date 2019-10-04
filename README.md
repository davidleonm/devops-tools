# Jenkins-Test
Jenkins-test is my first project intended to learn about some DevOps tools such as Jenkins, Sonarqube and Docker.

## Composition
* **docker-compose.yml** - Orchestator of the instance. It runs a Jenkins node in Alpine, Python slave node in Alpine and a Sonarqube. All nodes use volumes to store persistent data. Note that you would have to configure all the nodes to make them be connected, such as SSH connections, passwords, etc.
* **Dockerfile** - Docker file to build the Python Alpine node.
* **jenkins_key** - SSH private key to connect Jenkins with the slave. Please use your own file :-).
* **jenkins_key.pub** - SSH Public key which is imported in the slave to allow connections from Jenkins.
* **LICENSE** - File with the license, basically it says that you can use the code as you wish.
* **README.md** - This file!
* **sshd_config** - File with configuration for SSH daemon, such as deny root connections, password authentication, change the port and some more.

## Usage
To run all the instances just run:
```bash
docker-compose up --build -d
```

When you want to stop the system, just execute:
```bash
docker-compose down
```
And all the containers will be stopped and deleted.

## Changelog
* **2.0.0** - Splitted Jenkins files from Python solution files.
* **1.0.0** - Updated the pipelines to deploy the solution after merging to master.
* **First release** - First release with a working suite of DevOps tools and a basic Python solution.

## License
Use this code as you wish! Totally free to be copied/pasted.