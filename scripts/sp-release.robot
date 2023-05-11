*** Settings ***
Library    Selenium2Library
Library  BuiltIn
Test Teardown    Close All Browsers

*** Variables ***
${browser}      chrome
${url}      file:///C:/Users/Purushotham-3186/Desktop/UI%20Testing/sp-release2.html
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window

Validate Text Field Name
    [Documentation]  Validates that the text field name matches the expected value
    [Tags]  text_field_validation
    [Arguments]  ${expected_name}  ${locator}
    ${actual_name}  Get Text    ${locator}
    Should Be Equal  ${actual_name}  ${expected_name}
#
#Add Custom Tags Test
#    [Documentation]  Validates that the text field
#    Execute Javascript  var spTag = document.createElement('sp-tag')
#    Execute Javascript  spTag.setAttribute('id', 'testAuto')
#    Execute Javascript  document.querySelector('body').appendChild(spTag)
#    Page Should Contain Element  custom=tag:testAuto

Validate Login data
    Element Should Be Visible    xpath=//input[contains(@id,'fn') and @name='FirstName']
    Page Should Contain Element  xpath=//input[@name='FirstName']
    Element Should Be Visible    xpath=//input[contains(@id,'ln') and @name='LastName']
    Page Should Contain Element   xpath=//input[contains(@id,'ln')]
    Input Text    xpath=//input[contains(@id,'fn') and @name='FirstName']      MahendraSingh
    #Input Text    name=LastName       dhoni
    Input Text    xpath=//input[contains(@id,'ln') and @name='LastName']      Dhoni

#Get Element By Custom Locator
#    [Arguments]  ${locator}
#    [Return]  ${element}
#    ${prefix} =  Set Variable  custom=
#    ${new_locator} =  Evaluate  "${prefix} + '${locator}'"
#    ${element} =  Run Keyword And Return  Page Should Contain Element  ${new_locator}
#    [Return]  ${element}


*** Test Cases ***
Open SpRelease
    Open Browser And Maximize
    Sleep    2
    Validate Text Field Name    First name    xpath=//div[contains(@id,'fir')]
    Sleep    2
    Validate Text Field Name    Last name     xpath=//div[contains(@id,'last')]
    Validate Login data
    #Click Button       xpath=//sp-tag[contains(@id,'for') and @name='testAuto']
    #Click Button       xpath=//sp-tag[@id='testAuto']
    #Click Button       xpath=//input[@name='Submit']
    #${elem} =  Get Element By Custom Locator   xpath=//sp-tag[@id='testAuto']
    #Log  ${elem}
#    Execute Javascript  var spTag = document.createElement('sp-tag')
#    Execute Javascript  spTag.setAttribute('id', 'testAuto')
    Execute Javascript  document.querySelector('body').appendChild(spTag)
    Wait Until Element Is Visible  custom=tag:testAuto
    Page Should Contain Element  custom=tag:testAuto
    Click Button       xpath=//sp-tag[@id='testAuto']
    Sleep    10
