*** Settings ***
Library    Selenium2Library
Library  BuiltIn
Test Teardown    Close All Browsers
*** Variables ***
${browser}      chrome
${url}      file:///C:/Users/Purushotham-3186/Desktop/Ui%20Task/Demo2/Demo2/demo2.html
${expected_title}      Login Screen
${Validation_message_username}      Password must be between 6 and 20 characters long.
${Validation_message_password}      Password must be between 8 and 20 characters long.
${Validation_message_both_uname_pass}      Please enter both username and password.
${placeholder_username}     Username
${placeholder_password}     Password
${placeholder_login}     Login
*** Keywords ***
Open browser and maximize
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window
Validate Page Title
    #Validation one
    Title Should Be     ${expected_title}
    #Validation 2
    ${actual_title}    Get Title
    Should Be Equal    ${expected_title}      ${actual_title}
Input Username
    [Arguments]    ${username}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]    ${username}
Input Password
    [Arguments]    ${password}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]    ${password}
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
Validate Error Message
    [Arguments]    ${expected_message}    ${error_message_locator}
    ${actual_message}    Get Text    ${error_message_locator}
    Should Be Equal As Strings    ${expected_message}    ${actual_message}
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
Submit Login
    [Arguments]    ${username}      ${password}
    Input Username   ${username}
    Input Password   ${password}
    Click Button    xpath=//button[@type="submit"]
Validate Element visibility and displayed in screen
    #With in-built locator
    Page Should Contain Element     xpath=//input[@name="username"]
    #With Custom Tag
    Page Should Contain Element     xpath=//custom-login/form/input[@name="username"]
    #With custom locater
    Page Should Contain Element      xpath://input[@clocator="uname"]

    #With in-built locator
    Page Should Contain Element     xpath=//custom-login/form/input[@name="password"]
    #With Custom Tag
    Page Should Contain Element     xpath=//custom-login/form/input[@name="password"]
     #With custom locater
    Page Should Contain Element     xpath://input[@clocator="pass"]

    #With in-built locator
    Page Should Contain Element     xpath=//button[@type="submit"]
    #With Custom Tag
    Page Should Contain Element     xpath=(//custom-login[@id="custoTag"])/descendant::button[1]
     #With custom locater
    Page Should Contain Element     xpath://button[@clocator="submit"]



    #With in-built locator
    Page Should Contain Textfield     xpath=//input[@name="username"]
    #With Custom Tag
    Page Should Contain Textfield     xpath=//custom-login/form/input[@name="username"]
    #With custom locater
    Page Should Contain Textfield      xpath://input[@clocator="uname"]

    #With in-built locator
    Page Should Contain Textfield     xpath=//custom-login/form/input[@name="username"]
    #With Custom Tag
    Page Should Contain Textfield     xpath=//custom-login/form/input[@name="username"]
     #With custom locater
    Page Should Contain Textfield     xpath://input[@clocator="pass"]

    #With Custom Tag
    Wait Until Element Is Visible       xpath=//custom-login/form/input[@name="username"]
    #With custom locater
    Wait Until Element Is Enabled       xpath://input[@clocator="uname"]

    #With Custom Tag
    Wait Until Element Is Visible       xpath=//custom-login/form/input[@class="passwordClass"]
    #With custom locater
    Wait Until Element Is Enabled       xpath://input[@clocator="pass"]

    #With custom locater
    Wait Until Element Is Visible       xpath://button[@clocator="submit"]
    #With in-built locator
    Wait Until Element Is Enabled       xpath=//button[@type="submit"]
Validate Placeholder Values
    #With in-built locator
    ${username}     Get Element Attribute    xpath=//input[@name="username"]    placeholder
    Should Be Equal    ${placeholder_username}   ${username}
    #With Custom Tag
    ${username}     Get Element Attribute    xpath=//custom-login/form/input[@id="usernameId"]    placeholder
    Should Be Equal    ${placeholder_username}   ${username}
    #With Custom Locartor
    ${username}     Get Element Attribute    xpath://input[@clocator="uname"]    placeholder
    Should Be Equal    ${placeholder_username}   ${username}

    #With in-built locator
    ${password}     Get Element Attribute    xpath=//input[@name="password"]    placeholder
    Should Be Equal    ${placeholder_password}   ${password}
    #With Custom Tag
    ${password}     Get Element Attribute    xpath=//custom-login/form/input[@id="passwordId"]    placeholder
    Should Be Equal    ${placeholder_password}   ${password}
    #With Custom Locartor
    ${username}     Get Element Attribute    xpath://input[@clocator="pass"]    placeholder
    Should Be Equal    ${placeholder_password}   ${password}

    #With in-built locator
    ${lbutton}     Get Text    xpath=//button[@name="login"]
    Should Be Equal    ${placeholder_login}   ${lbutton}
    #With Custom Tag
    ${password}     Get Text    xpath=//custom-login/form/button[@id="submitId"]
    Should Be Equal    ${placeholder_login}   ${lbutton}
    #With Custom Locartor
    ${username}     Get Text    xpath://button[@clocator="submit"]
    Should Be Equal    ${placeholder_login}   ${lbutton}
Validate Text
    [Arguments]    ${text}
    Page Should Contain    ${text}
    #With Custom tag and Custom locator
    Page Should Contain Element    //custom-title[@cctitle="login"]
Validate Username Length
    [Arguments]    ${user_input}
    ${username}    Set Variable    ${user_input}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]    ${username}
    # Validating min and max length
    ${username_length}    Get Length    ${username}
    Run Keyword If    ${username_length} < 6 or ${username_length} > 20   Fail    Username must be between 6 and 20 characters long.
    Log    Username Validated
Validate Password Length
    [Arguments]    ${user_input}
    ${password}    Set Variable    ${user_input}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]    ${password}
    # Validating min and max length
    ${password_length}    Get Length    ${password}
    Run Keyword If    ${password_length} < 8 or ${password_length} > 20   Fail    Password must be between 8 and 20 characters long.
    Log    Password Validated
Get Length
    [Arguments]    ${string}
    [Documentation]    Returns the length of the given string
    [Return]    ${length}
    ${length}    Evaluate    len("${string}")
Clear Form
    # Clear the form
    Clear Element Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]
    Clear Element Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]
Validate Username and Password and Length also
    [Arguments]    ${username}      ${password}
    [Documentation]    Validating Username and Password fields
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Username"]    ${username}
    Input Text    xpath=//custom-login[@id="custoTag"]/form/input[@placeholder="Password"]    ${password}
    ${username}    Set Variable    ${username}
    ${password}    Set Variable    ${password}
    ${username_length}    Get Length    ${username}
    ${password_length}    Get Length    ${password}

    # Check if username and password are empty
    Run Keyword If    '${username}' == ''     Fail    Username is required
    Run Keyword If    '${password}' == ''    Fail    Password is required
    Run Keyword If    '${username}' == '' or '${password}' == ''    Fail    Both are required
    Run Keyword If    '${username}' == '' and '${password}' != ''     Fail    Username is required
    Run Keyword If    '${username}' != '' and '${password}' == ''     Fail    Password is required
    Run Keyword If     (${username_length}<6 or ${password_length}<8) or (${username_length}>20 or ${password_length}>20)    Fail    Both are required
    Log    Username password is validated
Validate Form With Dynamic xpaths
    #With Dynamic data
    Page Should Contain Element     xpath=//custom-login/form[contains(@myid, 'my')]/input[@name="username"]
    #With Dynamic data
    Page Should Contain Element     xpath=//custom-login/form[contains(@myid, 'my')]/input[@name="password"]
     #With Custom Tag
    Wait Until Element Is Visible       xpath=//custom-login/form[contains(@myid, 'my')]/input[@name="username"]
    #With custom locater
    Wait Until Element Is Enabled       xpath=//custom-login/form[contains(@myid, 'my')]/input[@name="username"]
*** Test Cases ***
Open SpRelease
    Open Browser And Maximize
    Sleep    2
    Validate Page Title
    Validate Text      Login
    Validate Element visibility and displayed in screen
    Validate Placeholder Values
    Validate Username Length    inputyourvalue
    Validate Password Length     inputyourvalue
    Clear Form
    Sleep    2
    Validate Username and Password and Length also  aweghewr    wqegqwgwqh
    Clear Form
    Sleep    2
    Submit login    Mahendra    SinghDhoni


