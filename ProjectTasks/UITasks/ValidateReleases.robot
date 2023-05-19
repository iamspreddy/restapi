*** Settings ***
Library    Selenium2Library
Library  BuiltIn
Test Teardown    Close All Browsers


*** Variables ***
${browser}      chrome
#${url}      file:///C:/Users/Purushotham-3186/Downloads/Demo/Demo/demo1.html
${url}      file:///C:/Users/Purushotham-3186/Downloads/Demo/Demo2/demo2.html
${VALIDATION_MESSAG}    Please fill out this field.
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window

#With JavaScript Validate Error Message
#    ${validation_message_element}    Execute JavaScript    return document.getElementById('validation-message');
#    ${validation_message}    Execute JavaScript    return arguments[0].textContent;    ${validation_message_element}
#    Should Be Equal As Strings    ${validation_message}    ${VALIDATION_MESSAG}
#

#Login Form Should Have Validation Message
#    ${validation_message_element}    Execute JavaScript    return document.getElementById('validation-message');
##    ${validation_message}    Call Method    ${validation_message_element}    get_attribute    innerText
#    ${validation_message}    Get Text    ${validation_message_element}
#    Should Be Equal As Strings    ${validation_message}    ${VALIDATION_MESSAG}



Login Form Should Not Have Validation Message
    Run Keyword And Return Status    Page Should Not Contain Element    ${VALIDATION_MESSAG}
    ${is_visible}    Run Keyword And Return Status    Element Should Be Visible    ${VALIDATION_MESSAG}
    Run Keyword If    ${is_visible}    Log    Validation message is displayed: ${is_visible}
    Run Keyword Unless    ${is_visible}    Log    Validation message is not displayed: ${is_visible}


Validate Error Message Text
    [Arguments]    ${expected_error_message}    ${locator_details}      ${attributeName}
    ${actualVal}    Selenium2Library.Get Element Attribute    ${locator_details}    ${attributeName}
    IF    '${actualVal}' == '${expectedErrorMessage}'
        Log   Error message is displayed as expected
    ELSE
        Log    Error message is not as expected.
    END
Retrieve Attributes
    # Get element by ID
    @{usernameInput}    Get WebElements    id=usernameId
    @{passwordInput}    Get WebElements    id=passwordId
    @{loginButton}    Get WebElements    id=submitId

    # Get attribute values
    ${validationMessage}    Get Element Attribute    id=validation-message    text
    ${customValidationMessage}    Get Element Attribute    id=login-form    data-validation-message

    Log    Username Input: ${usernameInput}
    Log    Password Input: ${passwordInput}
    Log    Login Button: ${loginButton}
    Log    Validation Message: ${validationMessage}
    Log    Custom Validation Message: ${customValidationMessage}

Input Username
    [Arguments]    ${username}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]    ${username}
Input Password
    [Arguments]    ${password}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]    ${password}

Validate Error Message
    [Arguments]    ${expected_message}    ${error_message_locator}
    ${actual_message}    Get Text    ${error_message_locator}
    Should Be Equal As Strings    ${expected_message}    ${actual_message}

Get JavaScript Reference
    [Arguments]    ${element}
    [Return]    return arguments[0]

Validate Login data
#Possible xpaths for Username
    #//input[contains(@class, "username")]
    #//input[@id="usernameId"]/following-sibling::button
    #//button[@id="submitId"]/ancestor::custom-login
    #//form/child::input
    #//custom-login/form/input[@id="usernameId"]
    #//custom-login/form/input[@class="usernameClass"]
    #//custom-login/form/input[@name="username"]
    #//custom-login/form/input[@type="text"]
    #//custom-login/form/input[@placeholder="Username"]
    #(//custom-login/form/input[@required])[1]
# Possible X paths for Password
    #//input[@id="usernameId"]/following-sibling::input[@id="passwordId"]
    #//input[@id="usernameId"]//following-sibling::input
    #//custom-login/form/input[@id="passwordId"]
    #//custom-login/form/input[@class="passwordClass"]
    #//custom-login/form/input[@name="password"]
    #//custom-login/form/input[@type="password"]
    #//custom-login/form/input[@placeholder="Password"]
    #(//custom-login/form/input[@required])[2]
    Wait Until Element Is Visible       xpath=//custom-login/form/input[@name="username"]
    Wait Until Element Is Enabled       xpath=//custom-login/form/input[@id="usernameId"]
    Wait Until Element Is Visible       xpath=//custom-login/form/input[@class="passwordClass"]
    Wait Until Element Is Enabled       xpath=//custom-login/form/input[@type="password"]
    Wait Until Element Is Visible       xpath=//button[@type="submit"]
    Wait Until Element Is Enabled       xpath=//button[@type="submit"]
Submit login data
    [Arguments]    ${username}  ${password}
    Input Username      ${username}
    Input Password    ${password}

#Get All Attributes of Field
#    ${field_element}    Get WebElement    xpath=//custom-login/form/input[@name="username"]
#    ${outer_html}    Get Element Attributes    ${field_element}
#    ${element_str}    Convert To String    ${field_element}
#    ${all_attributes}    Execute JavaScript    return (function(element) {var attrs = {};Array.from(element.attributes).forEach(function(attr) {attrs[attr.name] = attr.value;});return attrs;})(arguments[0])    ${outer_html}
#    Log Many    ${all_attributes}

*** Test Cases ***
Open SpRelease
    Open Browser And Maximize
    Sleep    2
#    Get All Attributes of Field

#    Validate Login Data
#    Input Username    ${EMPTY}
#    Click Button    xpath=//button[@type="submit"]
#    Wait Until Element Is Visible    css=.error
#    Wait Until Page Contains Element    css=.error
#    ${errorElementText}    Get Text    css=.error
#    Login Form Should Have Validation Message
#    Wait Until Page Contains Element    id=data-validation-message    timeout=10s
#    Validate Error Message
#    Validate Error Message Text    Please fill out this field.     xpath:
#    Click Button    xpath=//button[@type="submit"]


    #Submit login data      Mahendra    password
    #Element Should Not Be Visible    //p[@id="validation-message"]

##Working Code
    Input Username    Sanjay
    Click Button    xpath=//button[@type="submit"]
    Capture Element Screenshot    //p[@id="validation-message"]
    Page Should Contain    Please enter both username and password.
    Validate Error Message      Please enter both username and password.      //p[@id="validation-message"]
    Click Button       xpath=//button[@type="submit"]
    Sleep    2
###Valid Data Submit
#    Submit login data   Ramesh  password
