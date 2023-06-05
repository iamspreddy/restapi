*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSON
Library    String

*** Test Cases ***
Send POST Requests for Employees
    ${employees}    Get File    ${CURDIR}/employees.json
    ${employee_list}    Evaluate    json.loads('''${employees}''')['data']
    FOR    ${employee}    IN    @{employee_list}
        Post Employee Data    ${employee}
        Validate Employee Data    ${employee}
    END
    Put Employee Data    ${employee_list}[4]
    Validate Updated Employee Data    ${employee_list}[4]
    Put Employee Data    ${employee_list}[4]
    Validate Updated Employee Data    ${employee_list}[4]
    Delete Employee Data    ${employee_list}[9]
    Verify Employee Deleted    ${employee_list}[9]
    Log To Console    ${employee_list}


*** Keywords ***
Post Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${json_data}    Evaluate    json.dumps(${employee})
    Create Session    mySession    ${url}
    ${response}    Post Request    mySession    api/studentsDetails    headers=${headers}    json=${json_data}
    Should Be Equal As Strings    ${response.status_code}    201

Validate Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${query_params}    Create Dictionary    first_name=${employee['first_name']}    middle_name=${employee['middle_name']}    last_name=${employee['last_name']}    date_of_birth=${employee['date_of_birth']}
    Create Session    mySession    ${url}
    ${response}    Get Request    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    Should Be Equal As Strings    ${response_data['first_name']}    ${employee['first_name']}
    Should Be Equal As Strings    ${response_data['middle_name']}    ${employee['middle_name']}
    Should Be Equal As Strings    ${response_data['last_name']}    ${employee['last_name']}
    Should Be Equal As Strings    ${response_data['date_of_birth']}    ${employee['date_of_birth']}

Put Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${first_name}    Set Variable    ${employee['first_name']}
    ${middle_name}    Set Variable    ${employee['middle_name']}
    ${last_name}    Set Variable    ${employee['last_name']}
    ${date_of_birth}    Set Variable    ${employee['date_of_birth']}

    # Update date of birth for the fifth student
    ${updated_date_of_birth}    Set Variable    12-12-1990
    ${body}    Create Dictionary    first_name=${first_name}    middle_name=${middle_name}    last_name=${last_name}    date_of_birth=${updated_date_of_birth}
    ${json_data}    Evaluate    json.dumps(${body})
    Create Session    mySession    ${url}
    ${response}    Put Request    mySession    api/studentsDetails/${employee['id']}    headers=${headers}    data=${json_data}
    Should Be Equal As Strings    ${response.status_code}    200

Validate Updated Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${query_params}    Create Dictionary    first_name=${employee['first_name']}    middle_name=${employee['middle_name']}    last_name=${employee['last_name']}    date_of_birth=${employee['date_of_birth']}
    Create Session    mySession    ${url}
    ${response}    Get Request    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    Should Be Equal As Strings    ${response_data['first_name']}    ${employee['first_name']}
    Should Be Equal As Strings    ${response_data['middle_name']}    ${employee['middle_name']}
    Should Be Equal As Strings    ${response_data['last_name']}    ${employee['last_name']}
    Should Be Equal As Strings    ${response_data['date_of_birth']}    12-12-1990

Delete Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    Create Session    mySession    ${url}
    ${response}    Delete Request    mySession    api/studentsDetails/${employee['id']}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200

Verify Employee Deleted
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${query_params}    Create Dictionary    first_name=${employee['first_name']}    middle_name=${employee['middle_name']}    last_name=${employee['last_name']}    date_of_birth=${employee['date_of_birth']}
    Create Session    mySession    ${url}
    ${response}    Get Request    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    404
