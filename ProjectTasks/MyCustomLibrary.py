from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


class MyCustomLibrary:

    @keyword
    def read_file(self, file_path):
        with open(file_path, 'r') as file:
            return file.read()

    @keyword
    def should_contain_key(self, dictionary, key):
        if key not in dictionary:
            BuiltIn().fail(f"Key '{key}' not found in the dictionary: {dictionary}")
