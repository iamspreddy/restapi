*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}      http://www.google.com
${browser}      chrome
*** Keywords ***
Open Browser1

    Open Browser    ${url}     ${browser}
    Sleep    3

*** Test Cases ***
 Google Page Opening
    Open Browser1
    Select Frame    xpath://iframe[@name="callout"]
    Click Element    xpath://button[text()="No thanks"]
    sleep    200
    Handle Alert

    Select Frame    xpath://div[@role="region" and @jsname="EfADOe"]
    Click Element    xpath://*[@jsname="ZnuYW"]
    Switch Window    'MAIN'
    Sleep    2
    Input Text    css:input[name="q"]       msdhoni