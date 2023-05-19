import unittest
from APITas import TestModule1
from test_module2 import TestModule2

# Create a test suite
suite = unittest.TestSuite()

# Add test cases or test modules to the test suite
suite.addTest(unittest.makeSuite(TestModule1))
suite.addTest(unittest.makeSuite(TestModule2))

# Run the test suite
runner = unittest.TextTestRunner()
runner.run(suite)
