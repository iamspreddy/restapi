from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


@keyword
def get_element_attributes(element):
    driver = BuiltIn().get_library_instance('SeleniumLibrary').driver
    attrs = {}
    for attr in driver.execute_script("""
        var attrs = {};
        Array.from(arguments[0].attributes).forEach(function(attr) {
            attrs[attr.name] = attr.value;
        });
        return attrs;
    """, element):
        attrs[attr["name"]] = attr["value"]
    return attrs
