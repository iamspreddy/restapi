*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    JSONLibrary

*** Variables ***
${url}            https://thetestingworldapi.com
${API Endpoint}   /api/studentsDetails
${Headers}        Content-Type: application/json
${employee}     []
*** Test Cases ***
Example Test Case
    ${employees}    Create Employee List
    FOR    ${employee}    IN    @{employees}
        ${response}    Post Employee Data    ${employee}
        Log    ${response.content}
        Should Be Equal As Strings    ${response.status_code}    201
    END

*** Keywords ***
Create Employee
    [Arguments]    ${first_name}    ${middle_name}    ${last_name}    ${date_of_birth}
    ${employee}    Create Dictionary    first_name=${first_name}    middle_name=${middle_name}    last_name=${last_name}    date_of_birth=${date_of_birth}
    [Return]    ${employee}

Create Employee List
    ${body0}    Create Employee    Ganesha    Vinayaka    Shiva    1/12/1992
    ${body1}    Create Employee    John    Doe    Smith    5/25/1985
    ${body2}    Create Employee    Alice   Jane   Doe     10/15/1990
    ${body3}    Create Employee    Ganesha    Vinayaka    Shiva    1/12/1992
    ${body4}    Create Employee    John    Doe    Smith    5/25/1985
    ${body5}    Create Employee    Alice   Jane   Doe     10/15/1990
    ${body6}    Create Employee    Alice   Jane   Doe     10/15/1990
    ${body7}    Create Employee    Ganesha    Vinayaka    Shiva    1/12/1992
    ${body8}    Create Employee    John    Doe    Smith    5/25/1985
    ${body9}    Create Employee    Alice   Jane   Doe     10/15/1990
   ${employee}=  Create List    ${body0}    ${body1}    ${body2}    ${body3}    ${body4}    ${body5}    ${body6}    ${body7}    ${body8}    ${body9}
    ${employee}=    Set Global Variable    ${employee}
    Log To Console    ${employee}
    [Return]    ${employee}
Post Employee Data
    [Arguments]   ${employee}
    ${employee}=    Create List    ${body0}    ${body1}    ${body2}    ${body3}    ${body4}    ${body5}    ${body6}    ${body7}    ${body8}    ${body9}
    Create Session    mySession    ${url}
    FOR    ${employe}   IN     ${employee}:
            ${json}    Set Variable    ${employe}
            ${employee}    Evaluate    ${json}
            ${response}=    POST On Session    mySession    ${API Endpoint}    json=${employee}    headers=${Headers}
    Log To Console    ${response}
    Log    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    201
    END

