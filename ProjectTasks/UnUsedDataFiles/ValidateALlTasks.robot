*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
Create Employee
    [Setup]    Create Session    employees    http://localhost:8000
    ${headers}    Create Dictionary    Content-Type=application/json
    ${employee_data}    Create Dictionary    id=1    name=John Doe    department=IT
    ${url}    Catenate    SEPARATOR=    /employees
    ${response}    POST On Session    employees    url=${url}    json=${employee_data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.json()}
    Should Contain    ${response_body}[message]    Employee created successfully

Get Employees
    [Setup]    Create Session    employees    http://localhost:8000
    ${url}    Catenate    SEPARATOR=    /employees
    ${response}    GET On Session    employees    url=${url}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.json()}
    Length Should Be    ${response_body}    1
    Should Contain    ${response_body}[0][id]    1
    Should Contain    ${response_body}[0][name]    John Doe
    Should Contain    ${response_body}[0][department]    IT

Delete Employee
    [Setup]    Create Session    employees    http://localhost:8000
    ${url}    Catenate    SEPARATOR=    /employees/1
    ${response}    DELETE On Session    employees    url=${url}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.json()}
    Should Contain    ${response_body}[message]    Employee deleted successfully
