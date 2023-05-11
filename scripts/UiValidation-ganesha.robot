*** Settings ***
Library    Selenium2Library

*** Test Cases ***
Facebook validation
     Set Selenium Implicit Wait    20
     Open Browser    http://the-internet.herokuapp.com/       chrome
     Click Element    xpath=//a[text()='Checkboxes']
     Checkbox Should Not Be Selected    //form[@id="checkboxes"]//following-sibling::input/preceding::input
     Click Button    xpath=//form[@id="checkboxes"]//following-sibling::input/preceding::input
     sleep   5

