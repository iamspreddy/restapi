*** Settings ***
Library    Selenium2Library

*** Test Cases ***
Facebook validation
     Set Selenium Implicit Wait    20
     Open Browser    http://www.facebook.com       chrome
     Input Text      id=email       spreddy1217@gmail.com
     Input Password    id=pass      Wonderland@1
     Click Button    name=login

