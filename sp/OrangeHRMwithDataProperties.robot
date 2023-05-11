*** Settings ***
Variables       properties.py
Library    Selenium2Library

*** Keywords ***

Login to OrangeHRM
    Input Text    name:username     ${properties.username}
    Input Text    name:password     ${properties.password}
    Click Button    css:button.oxd-button
*** Test Cases ***
Sample test runner
     Open Browser   ${properties.url}      ${properties.browser}
     Set Selenium Implicit Wait    20
     Maximize Browser Window
     Login to OrangeHRM


