*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${LOGIN_URL}    file:///C:/Users/Purushotham-3186/Desktop/UI%20Testing/Site1.html    # Replace with the actual login page URL

*** Test Cases ***
Validate Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Set Selenium Implicit Wait    10
    Title Should Be    Login Page
    Submit Formqqq
    Sleep    1
    Wait Until Element Is Visible    css=.error
    Element Text Should Be    css=.error    Please fill out this field.
    Close Browser
