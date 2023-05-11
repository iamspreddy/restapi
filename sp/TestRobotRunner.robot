*** Settings ***
Library    Selenium2Library
Library    String
Library    RobotFramework
Suite Setup    Launch Browser and and other activities
Suite Teardown     Close All Browsers
*** Variables ***
${userName}
${password}
${input3}
${url}      htttp://www.google.com
${browser}   chrome
*** Keywords ***
Sample Run
    Set Suite Variable    ${userName}     ${userName}
    Set Suite Variable    ${password}     ${password}
Launch Browser and and other activities
     Open Browser    ${url}      ${browser}
     Set Selenium Implicit Wait    20
     Maximize Browser Window

*** Test Cases ***
Sample test runner
    Sleep    1


