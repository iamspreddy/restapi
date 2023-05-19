*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem
Library           MyCustomLibrary
*** Variables ***
${BASE_URL}       https://thetestingworldapi.com/
${EMPLOYEE_DATA}  employees.json

*** Test Cases ***
Create Employee Data
    [Documentation]     Create employee data using POST method
    ${data}             Read File    ${EMPLOYEE_DATA}
    ${headers}          Create Dictionary    Content-Type=application/json
    ${response}         Post Request    ${BASE_URL}/employees    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${response_data}    Set Variable    ${response.json()}
    Should Contain Key    ${response_data}    id
    Log                 Employee created with ID: ${response_data['id']}

*** Keywords ***
Post Request
    [Arguments]    ${url}    ${json}    ${headers}
    Create Session    example_api    ${BASE_URL}
    ${response}    Post Request    example_api    ${url}    json=${json}    headers=${headers}
    [Return]    ${response}
