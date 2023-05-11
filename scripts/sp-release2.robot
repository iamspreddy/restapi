*** Settings ***
Library    Selenium2Library

*** Variables ***
${browser}      chrome
${url}      file:///C:/Users/Purushotham-3186/Desktop/UI%20Testing/sp-release2.html
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window

*** Test Cases ***
Open SpRelease1
    Open Browser And Maximize
