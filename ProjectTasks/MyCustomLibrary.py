import base64

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

    @keyword
    def decode_base64_to_string(content):
        decoded_bytes = base64.b64decode(content)
        decoded_string = decoded_bytes.decode('utf-8')
        return decoded_string
