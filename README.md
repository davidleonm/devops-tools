# Jenkins-Test
Jenkins-test is my first project intended to learn about some DevOps tools such as Jenkins, Sonarqube and Docker.

## Composition
* **Docker** - Folder where configuration and necessary files to run the system are stored. Note that you have to use your own jenkins key to connect to the slave.
* **PythonHelloWorld** - Folder with a basic Python Flask API and unit tests.
* ***<Root>***
  * **Jenkins files** - Files with Jenkins pipelines, separating branches and master branch.
  * **README.md** - This file!
  * **sonar-project.properties** - File with configuration to execute Sonarqube analysis during master build.


## Usage
### Docker containers
To run the containers with Jenkins, its Slave and Sonarqube, you just need to execute:
```bash
docker-compose up --build -d
```

When you want to stop the system, just execute:
```bash
docker-compose down
```
And all the containers will be stopped and destroyed. Don't worry about the data because it is persistent in the volumes created.

### Python solution
As said, it is only a basic Python Flask which runs a listener in the port 9999. Using curl, any browser or a rest client, you can get the result.
Being Python 3 previously installed, just execute:
```bash
python hello_world.py
```
And to query the API:
```bash
curl http://127.0.0.1:9999/helloworld
```

## Changelog
* **First release** - First release with a working suite of DevOps tools and a basic Python solution.


## License
Use this code as you wish!