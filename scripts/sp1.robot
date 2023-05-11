*** Settings ***
Library    Selenium2Library
*** Variables ***
${url}      http://www.google.com
${browser}     chrome
${boolVal}      True
${frame_Present}
*** Keywords ***
Open Browser1
    Open Browser    ${url}     ${browser}
    Maximize Browser Window
Verify Callout Frame present or not
    [Arguments]    ${locator}
    [Documentation]    please enter locator info
    Element Should Be Visible    ${locator}
    Set Suite Variable    ${frame_Present}    True

Handle callout frame
    IF  ${frame_Present}
        #Element Should Be Visible    xpath://iframe[@name="callout"]
        Select Frame    xpath://iframe[@name="callout"]
        Click Element    xpath://button[text()="No thanks"]
    END
Handle Later popup
    IF  ${boolVal}
        Element Should Be Visible    Xpath://g-flat-button[text()='Later']
        Click Element    Xpath://g-flat-button[text()='Later']
    END
Search value in chrome
    Input Text    css:input[name="q"]       msdhoni
Implicit Timeout for class
    Set Selenium Implicit Wait      10
*** Test Cases ***
 Google Page Opening
    Implicit Timeout for class
    Open Browser1
    Run Keyword And Continue On Failure    Verify Callout Frame present or not     xpath://iframe[@name="callout1"]
    Handle callout frame
    Switch Window
    Handle Later popup
    Search value in chrome

Google Page Opening1
    Implicit Timeout for class
    Open Browser1
    Handle callout frame
    Switch Window
    Handle Later popup
    Search value in chrome

Alerts handling in robotframework
    Implicit Timeout for class
    Open Browser1

    Handle callout frame
    Switch Window
    Handle Later popup
    Search value in chrome