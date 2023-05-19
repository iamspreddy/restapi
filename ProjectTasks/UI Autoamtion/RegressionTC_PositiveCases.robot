*** Settings ***
Library    Selenium2Library
Library  BuiltIn
Test Teardown    Close All Browsers

*** Variables ***
${browser}      chrome
${url}      file:///C:/Users/Purushotham-3186/Desktop/Ui%20Task/Demo1/Demo/demo1.html
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window
Submit Login
    [Arguments]    ${username}      ${password}
    Input Username   ${username}
    Input Password   ${password}
    Click Button    xpath=//button[@type="submit"]

Input Username
    [Arguments]    ${username}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]    ${username}
Input Password
    [Arguments]    ${password}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]    ${password}

*** Test Cases ***
Open SpRelease
    Open Browser And Maximize
    Sleep    2
    Submit Login    Sanjay   password
    Capture Page Screenshot
    Sleep    2
