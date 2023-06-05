*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections
Library    String
Library    OperatingSystem
Suite Setup    Test Automation Task 2
Suite Setup    Close All Browsers
*** Variables ***
${browser}      chrome
${url}      https://terralogic.paxanimi.ai/login
${username}     purushothama.reddy@terralogic.com
${password}     Wonderland@1
@{leave_Types}=     Create List    Sick Leave   PTO   LOP    Paternity Leave   Maternity Leave   Work From Home   Onsite Visit
${url_gmail}      https://accounts.google.com/v3/signin/identifier?dsh=S184602223%3A1684844772943788&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ifkv=Af_xneGRrXWwn3bQJghPip8G_1FpSKzvXQ4_qVDGgIGSnu_pShr0AzX9A_Py4whLkQ_6jEB0v3tU9A&rip=1&sacu=1&service=mail&flowName=GlifWebSignIn&flowEntry=ServiceLogin
${new_title}    [HR-OS] - PTO Request from Purushothamareddy Simati (purushothama.reddy / PSI - 3186) - purushothama.reddy@terralogic.com - TerraLogic Software Solutions Inc. Mail
${old_title}    HR-OS
*** Keywords ***
Setup Test Suite
    Log    Setting up the test suite
Teardown Suite
    Log    Tearing down the test suite
Select Datepicker Date
    [Documentation]     Select given day from datepicker
    [Arguments]     ${dateElem}     ${expectedMonthYear}    ${clickElement}
    Input Text  ${dateElem}    ${Empty}    # open the datepicker
    ${monthyear}=   Get Datepicker MonthYear
    FOR    ${Index}    IN RANGE    1   31
       Run Keyword If  '${monthyear}' == '${expectedMonthYear}'   Exit For Loop
       Click Link    //*/div[@id='ui-datepicker-div']//*/a[contains(@class, 'ui-datepicker-prev')]
       ${monthyear}=   Get Datepicker MonthYear
    Click Link    ${clickElement}
    END
Get Datepicker MonthYear
    [Documentation]     Return current month + year from datepicker
    [Return]    ${monthyear}
    ${month}=   Get Text  //*/div[@id='ui-datepicker-div']//*/div[@class='ui-datepicker-title']/span[@class='ui-datepicker-month']
    ${year}=    Get Text  //*/div[@id='ui-datepicker-div']//*/div[@class='ui-datepicker-title']/span[@class='ui-datepicker-year']
    ${monthyear}=   Catenate    ${month}  ${year}
Click Leave dropdown
    Wait Until Element Is Visible    xpath:(//div[@class="ant-select-selector"])[1]
    Click Element    xpath:(//div[@class="ant-select-selector"])[1]
Leave Type Selection
    [Arguments]    ${user_requested_leave_type}
    Click Leave dropdown
    ${leave_type_matched}=    Set Variable    ${False}
    FOR    ${leave_type}    IN    @{leave_types}
        IF    "${leave_type}" == "${user_requested_leave_type}"
            Log    The user input matches the leave type: ${leave_type}
            Set Variable    ${leave_type_matched}    ${True}
            Click Element    xpath://div[@class="timeOffTypeOptions___2ShCV"]//span[text()='${leave_type}']
        END
    END
    Run Keyword if    ${leave_type_matched}  Log To Console    User input does not match any leave type
        # Additional actions for non-matching input
    [Teardown]    Run Keywords

Click Time Off Option
    Click Element    xpath:(//a[@href="/time-off"])[1]
Click Request Time OFF
    Click Element    xpath://span[text()="Request Time Off"]
Input Terralogic Username
    [Arguments]    ${username}
    Input Text    xpath://input[@type="email"]   ${username}
Input Terralogic Password
    [Arguments]    ${password}
    Input Text    xpath://input[@type="password"]    ${password}
Click Next Button
    Wait Until Element Is Visible    xpath://span[text()='Next']
    Click Element    xpath://span[text()='Next']
Click Terralogic Login
    Wait Until Element Is Visible    xpath://span[text()='Terralogic Login']
     Click Element    xpath://span[text()='Terralogic Login']
##This wait we required to use Manual Interruption
General Sleep slowness of site
    [Arguments]    ${sllep_value}
    Sleep    ${sllep_value}
Enter Subject Text
    [Arguments]    ${subject_leave}
    Wait Until Element Is Enabled    xpath:(//input[@class="ant-input"])[2]
    Click Element    xpath:(//input[@class="ant-input"])[2]
    Input Text    xpath:(//input[@class="ant-input"])[2]    ${subject_leave}
Click Submit Button
    Scroll Element Into View    xpath://button//span[text()="Submit"]
    Wait Until Element Is Enabled    xpath://button//span[text()="Submit"]
    Click Element    xpath://button//span[text()="Submit"]
Click On Duration DatePicker
    Wait Until Element Is Visible    (//div[@class="ant-select-selector"])[2]
    Click Element    (//div[@class="ant-select-selector"])[2]
    Sleep    4
Enter Description Text
    [Arguments]    ${description_text}
    # Scroll to an element identified by ID
    ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//textarea[@class="ant-input"])
    Run Keyword if    ${element_visible}    Scroll Element Into View    xpath:(//textarea[@class="ant-input"])
    Wait Until Keyword Succeeds    5s    1s    Element Should Be Visible   xpath:(//textarea[@class="ant-input"])
    Execute Javascript    window.scrollTo(0, 300)
    Click Element    xpath:(//textarea[@class="ant-input"])
    Input Text    xpath:(//textarea[@class="ant-input"])    ${description_text}
Click Tab
    [Arguments]    ${tab_name}
    Click Element    //div[contains(text(),'${tab_name}')]
Verify Leave Submitted Successfully
    Click Time Off Option
    General Sleep slowness of site    2
    Execute Javascript    window.scrollTo(0, 300)
    Sleep    4
    Click Tab    Leave Requests
    Sleep    4
    Click Tab   In Progress
    Sleep    4
    Execute Javascript    window.scrollTo(0, 300)
    Sleep    5
    Click Element    //th[text()="Type"]
    Click Element    xpath://div[contains(@class, 'MyLeaveTable___3tUyj')]
    ${val1}=   Get Text    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[1]
    ${val2}=    Get Text    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[2]
    ${val3}=   Get Text    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[3]
    ${val4}=    Get Text    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[4]
    Log     ${val1}
    Log     ${val2}
    Log     ${val3}
    Log     ${val4}
    Sleep    5
    Should Be Equal    New    ${val2}

    Log    Leave successfully applied

#Gmail Validation
Terralogic Gmail Login
#    [Arguments]    ${username}   ${password}
    Set Selenium Implicit Wait    17
    Maximize Browser Window
    Sleep    15
##    Login Process    ${username}    ${password}
    Validate Prompt and Click If Button Exists
    Validate Leave Email Details
Login Process
    [Arguments]    ${username}   ${password}
    Wait Until Element Is Visible    xpath://input[@id="identifierId"]
    Input Text    xpath://input[@id="identifierId"]     ${username}
    Click Element    //span[text()="Next"]
    Sleep    2
    Wait Until Element Is Visible    //input[@name="Passwd"]
    Input Text    //input[@name="Passwd"]       ${password}
    Sleep    5
    Click Element    //span[text()="Next"]
    Sleep   20
    Wait Until Element Is Visible    //span[text()="Next"]
    Page Should Contain Element    //span[text()="Next"]
    Click Element    //span[text()="Next"]
    Sleep   5
Validate Prompt and Click If Button Exists
    Element Should Be Visible    xpath=//div[text()="Pause mobile notifications while you're using this device"]/../..//button[text()="No thanks"]
    Click Element    xpath=//div[text()="Pause mobile notifications while you're using this device"]/../..//button[text()="No thanks"]
Validate Leave Email Details
    Input Text    //input[@name="q"]    terralogic@paxanimi.ai
    Press Keys    //input[@name="q"]    ENTER
    Sleep    4
    Click Element    xpath:(//div[text()="Mail"])[2]
    Sleep    3
    Click Element    xpath://div[text()='Inbox']/../../../../../../../..
    Sleep    2
#    Click Element    xpath:(//div[@class="y6"])[51]
    Scroll Element Into View    xpath://*[contains(text(),"If you have any questions")]
    Page Should Contain Element    xpath://*[contains(text(),"Leave Type")]
    Page Should Contain Element    xpath://*[contains(text(),"Leave Duration")]
    Page Should Contain     Request from Purushothamareddy Simati
    Page Should Contain    [HR-OS]
    Page Should Contain    PTO
    Page Should Contain    2 Days
    Page Should Contain    Hello World
    Sleep    3

Withdraw Leave Request Validation
    Click Time Off Option
    Sleep    3
    Click Tab   In Progress
    Sleep    3
    ${Leave_data_attributes}=   Get Text    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[1]
    ${Leave_data_attributes}=   Set Variable    ${Leave_data_attributes}
    Page Should Contain    ${Leave_data_attributes}
    Execute Javascript    window.scrollTo(0, 300)
    Scroll Element Into View    (//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[1]
    Click Element    xpath:(//div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr[2]//td//span[text()])[1]
    Sleep    3
    Page Should Contain Element    xpath://*[contains(text(),"Timeoff Type")]
    Page Should Contain Element    xpath://*[contains(text(),"Subject")]
    Page Should Contain Element    xpath://*[contains(text(),"Attachments")]
    Page Should Contain Element    xpath://*[contains(text(),"Duration")]
    Page Should Contain Element    xpath://span[text()="Withdraw"]
    Click Element    xpath://span[text()="Withdraw"]
    Sleep    5
    Click Element    xpath://*[text()="Proceed"]
    Sleep    10
    Click Time Off Option
    Sleep    10
    Click Tab    Withdrawn
    Sleep    5
    Execute Javascript    window.scrollTo(0, 600)
    Sleep    3
    Click Element    xpath://div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr//td//span[text()="${Leave_data_attributes}"]
    Sleep    6
    Page Should Contain Element    xpath://*[contains(text(),"Timeoff Type")]
    Page Should Contain Element    xpath://*[contains(text(),"Subject")]
    Page Should Contain Element    xpath://*[contains(text(),"Duration")]
    Page Should Contain Element    xpath://*[contains(text(),"Attachments")]
    Page Should Contain Element    xpath://*[contains(text(),"Description")]
    Page Should Contain     Note - Withdrawal of requests
    Page Should Contain    Waiting for Approval


Logout Terralogic
    Click Element    xpath://img[@class="gb_k gbii"]
    Sleep    3
    Select Frame    (//iframe[@role="presentation"])[2]
    Element Should Be Visible    xpath=//div//a//span//div[text()='Sign out']
    Wait Until Element Is Visible    xpath://div//a//span//div[text()='Sign out']
    Click Element    xpath://div//a//span//div[text()='Sign out']
    Sleep    4
    Log To Console    Page is logged out sucessfully
Logout HR_OS
    Click Image    xpath://img[@style="background-color: transparent;"]
    Wait Until Element Is Visible    xpath://span[text()='Logout']
    Log To Console    Logout element is visiable
    Click Element    xpath://span[text()='Logout']
    Sleep    4
    Page Should Contain    Login to Portal
    Log To Console    Page is logged out sucessfully

Test Automation Task 2
    Log    This is for Test Automation Task 2

*** Test Cases ***
Login to HR-OS Portal
    Open Browser    ${url}      ${browser}
    Set Selenium Implicit Wait    17
    Maximize Browser Window
    Click Terralogic Login
    Sleep    4
    Switch Window    New
    General Sleep slowness of site    5
    Maximize Browser Window
    Input Terralogic Username     ${username}
    Click Next Button
    General Sleep slowness of site    5
    Input Terralogic Password      ${password}
    Click Next Button
    General Sleep slowness of site    30
    Run Keyword And Continue On Failure    Click Next Button
    Switch Window    Main
    General Sleep slowness of site    20
    Click Time Off Option
    Sleep    10
    Click Tab    Withdrawn
    Sleep    5
    Execute Javascript    window.scrollTo(0, 600)
    Sleep    3
    Click Element    xpath://div[contains(@class, 'MyLeaveTable')]//tbody[@class="ant-table-tbody"]//tr//td//span[text()="42038055"]
    Sleep    6
    Page Should Contain Element    xpath://*[contains(text(),"Timeoff Type")]
    Page Should Contain Element    xpath://*[contains(text(),"Subject")]
    Page Should Contain Element    xpath://*[contains(text(),"Duration")]
    Page Should Contain Element    xpath://*[contains(text(),"Attachments")]
    Page Should Contain Element    xpath://*[contains(text(),"Description")]
    Page Should Contain     Note - Withdrawal of requests
    Page Should Contain    Waiting for Approval



