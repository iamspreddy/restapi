*** Settings ***
Library    Selenium2Library

*** Variables ***
${browser}      chrome
${url}      file:///C:/Users/Purushotham-3186/Desktop/UI%20Testing/sp-release1.html
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window

*** Test Cases ***
Open SpRelease1
    Open Browser And Maximize
    #Input Text    name=FirstName      MahendraSingh
    Input Text    xpath=//input[contains(@id,'fn') and @name='FirstName']      MahendraSingh
    #Input Text    name=LastName       dhoni
    Input Text    xpath=//input[contains(@id,'ln') and @name='LastName']      Dhoni
    Sleep    3
    #Click Button       //sp[contains(@id,'for') and @name='testAuto']
    Click Button       //sp-tag[@id='testAuto']
    #Click Button       //input[@name='Submit']
    Sleep    10
