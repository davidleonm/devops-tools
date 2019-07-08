import unittest

from HelloWorldFlask.hello_world import HelloWorldFlask


class AppUnitTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.flask_app = HelloWorldFlask('test').testing_client()

    def test_helloworld_returns_helloworld(self):
        response = self.flask_app.get('/helloworld').data
        self.assertEqual(response, 'Hello World!'.encode('utf8'))


if __name__ == '__main__':
    unittest.main()
