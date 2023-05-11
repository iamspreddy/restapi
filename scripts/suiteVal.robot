*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser And Maximize
Suite Teardown    Close All Browsers

*** Variables ***
${browser}      chrome
${url}      https://terralogic.paxanimi.ai/login

*** Test Cases ***
login status
    Click Element    xpath://span[text()='Terralogic Login']
    Sleep    4
    Switch Window    New
    Maximize Browser Window
    Input Text    xpath://input[@type="email"]     purushothama.reddy@terralogic.com
    Click Element    xpath://span[text()='Next']
    Sleep    4
    Input Text    xpath://input[@name="password"]      Wonderland@1
    Click Element    xpath://span[text()='Next']
    Sleep    10
Main page Automation
    Switch Window    Main
    Page Should Contain    Hello Simati Purushothama
    Log To Console    Main page
Timeoff
    Click Element    xpath:(//a[@href="/time-off"])[1]
    Log To Console    Timeoff element clicked
    Sleep    2

*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window
