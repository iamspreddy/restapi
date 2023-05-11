*** Settings ***
Library    Selenium2Library
Library    OperatingSystem
Variables    sp.properties


*** Test Cases ***
Sample test runner
     Open Browser   ${url}      ${browser}
     Set Selenium Implicit Wait    20
     Maximize Browser Window
     Input Text    name:username     ${username}
     Input Text    name:password     ${password}
     Click Button    css:button.oxd-button



