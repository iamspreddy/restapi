*** Settings ***
Library    Selenium2Library
Library    String
Library    RobotFramework
Resource    OrangeHrm.robot
Resource    __init__.py
Suite Setup    Launch Browser and other activities
#Suite Teardown     Close All Browsers
*** Variables ***
${input3}
${url}      https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}   chrome
*** Keywords ***
Launch Browser and other activities
     Open Browser    ${url}      ${browser}
     Set Selenium Implicit Wait    20
     Maximize Browser Window
Login to OrangeHRM
    Input Text    name:username     ${userName}
    Input Text    name:password     ${password}
    Click Button    css:button.oxd-button
*** Test Cases ***
Sample test runner
    Login To OrangeHRM



