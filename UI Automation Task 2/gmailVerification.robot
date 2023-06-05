*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String


*** Variables ***
${browser}      chrome
${url_sample}   www.ggogle.com
${url_gmail}      https://accounts.google.com/v3/signin/identifier?dsh=S184602223%3A1684844772943788&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ifkv=Af_xneGRrXWwn3bQJghPip8G_1FpSKzvXQ4_qVDGgIGSnu_pShr0AzX9A_Py4whLkQ_6jEB0v3tU9A&rip=1&sacu=1&service=mail&flowName=GlifWebSignIn&flowEntry=ServiceLogin
${username}     purushothama.reddy@terralogic.com
${password}     Wonderland@1
${email}    terralogic@paxanimi.ai

*** Keywords ***
Terralogic Gmail Login
    [Arguments]    ${username}   ${password}
    Open Browser    ${url_gmail}    ${browser}    newtab=True
    Set Selenium Implicit Wait    17
    Maximize Browser Window
    Login Process    ${username}    ${password}
    Sleep    5
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
    Sleep    3
*** Test Cases ***
Login to Terralogic email and verify the auto generated email
    Terralogic Gmail Login    ${username}    ${password}
