FROM python:3.7.3-alpine3.9
LABEL maintainer="David Leon <david.leon.m@gmail.com>"

# Copy the application script and its requirements
COPY PythonHelloWorld/HelloWorldFlask/hello_world.py /helloworld/app.py
COPY PythonHelloWorld/requirements.txt /helloworld/requirements.txt

# Install references
RUN pip install --upgrade pip
RUN pip install -r /helloworld/requirements.txt

# Default port for the application
EXPOSE 9999

# Start PythonHelloWorld
CMD ["python", "/helloworld/app.py"]