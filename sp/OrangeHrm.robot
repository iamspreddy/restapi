*** Settings ***
Library    Selenium2Library
Library    String
Library    RobotFramework
Suite Setup    Launch Browser and and other activities
#Suite Teardown     Close All Browsers
*** Variables ***
${userName}     Admin
${password}     admin123
${input3}
${url}      https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}   chrome
*** Keywords ***
Sample Run
    Set Suite Variable    ${userName}     ${userName}
    Set Suite Variable    ${password}     ${password}
Launch Browser and and other activities
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


