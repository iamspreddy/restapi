*** Settings ***
Documentation     Example Robot Framework Suite for API Testing
Library           RequestsLibrary
*** Variables ***
${url}=     https://thetestingworldapi.com/
*** Test Cases ***
Create employee data using the POST method Create 10 employees' data
    [Documentation]     This is the first API test case
    Create Session      mySession    ${url}
    ${headers}          Create Dictionary    Content-Type=application/json
    ${payload}          Create Dictionary    first_name=sp   middle_name=dhoni   last_name=dhoni    date_of_birth=03/04/1996
    ${response}         Post Request    mySession    api/studentsDetails    json=${payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.content}

Test Case 2
    [Documentation]     This is the second API test case
    Create Session      mySession    ${url}
    ${headers}          Create Dictionary    Content-Type=application/json
    ${payload}          Create Dictionary    first_name=sp   middle_name=dhoni   last_name=dhoni    date_of_birth=03/04/1996
    ${response}         Post Request    mySession    /login    json=${payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    401
    Log To Console    ${response.content}

Test Case 3
    [Documentation]     This is the third API test case
    Create Session      mySession    ${url}
    ${headers}          Create Dictionary    Content-Type=application/json
    ${payload}          Create Dictionary    username=example_user    password=example_password
    ${response}         Post Request    mySession    /logout    json=${payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.content}

*** Keywords ***
Create Session
    [Arguments]    ${name}    ${url}
    Create Session    ${name}    ${url}

Post Request
    [Arguments]    ${session_name}    ${endpoint}    ${json}    ${headers}
    ${response}    Post Request    ${session_name}    ${endpoint}    json=${json}    headers=${headers}
    [Return]    ${response}
