from flask import Flask


class HelloWorldFlask(object):
    app = None

    def __init__(self, name):
        self.app = Flask(name)
        self.app.add_url_rule('/', 'index', self.forbidden)
        self.app.add_url_rule('/helloworld', 'helloworld', self.helloworld)

    def run(self):
        self.app.run(host='0.0.0.0', port=9999)

    @staticmethod
    def helloworld():
        return 'Hello World!'

    @staticmethod
    def forbidden():
        return 'Forbidden site!'

    def testing_client(self):
        self.app.testing = True
        return self.app.test_client()


if __name__ == '__main__':
    flask_app = HelloWorldFlask('helloworld')
    flask_app.run()
