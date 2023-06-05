*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSON
Library    String
*** Variables ***
${url}    Set Variable    https://thetestingworldapi.com/
*** Test Cases ***
Send POST Requests for Employees
    ${employee_list}=   Post 10 Employees data
    Put Employee Data    ${employee_list}[4]
    Validate Updated Employee Data    ${employee_list}[4]
    ${deleted_employee_id}=     Delete Employee Data
    Validate Employee Data after Delete    ${deleted_employee_id}
    Print All List Of Employees after all Operations


*** Keywords ***
Post 10 Employees data
    [Return]    ${employee_list}
    ${employees}    Get File    ${CURDIR}/employees.json
    ${employee_list}    Evaluate    json.loads('''${employees}''')['data']
    FOR    ${employee}    IN    @{employee_list}
        Post Employee Data    ${employee}
        Validate Employee Data    ${employee}
    END
Post Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${first_name}    Set Variable    ${employee['first_name']}
    ${middle_name}    Set Variable    ${employee['middle_name']}
    ${last_name}    Set Variable    ${employee['last_name']}
    ${date_of_birth}    Set Variable    ${employee['date_of_birth']}
    ${body}    Create Dictionary    first_name=${first_name}    middle_name=${middle_name}    last_name=${last_name}    date_of_birth=${date_of_birth}
    ${json_data}    Evaluate    json.dumps(${body})
    Create Session    mySession    ${url}
    ${response}    Post Request    mySession    api/studentsDetails    headers=${headers}    data=${json_data}
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
    Should Be Equal As Strings    ${response_data[0]['first_name']}    ${employee['first_name']}
    Should Be Equal As Strings    ${response_data[0]['middle_name']}    ${employee['middle_name']}
    Should Be Equal As Strings    ${response_data[0]['last_name']}    ${employee['last_name']}
    Should Be Equal As Strings    ${response_data[0]['date_of_birth']}    ${employee['date_of_birth']}

Put Employee Data
    [Arguments]    ${employee}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json

    # Retrieve the 5th employee's ID
    ${query_params}    Create Dictionary    limit=5
    Create Session    mySession    ${url}
    ${response}    Get Request    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    ${employee_id}    Set Variable    ${response_data[4]['id']}

    # Update date of birth for the 5th employee
    ${updated_date_of_birth}    Set Variable    12-12-1996
    ${body}    Create Dictionary    id=${employee_id}   first_name=${response_data[4]['first_name']}    middle_name=${response_data[4]['middle_name']}    last_name=${response_data[4]['last_name']}    date_of_birth=${updated_date_of_birth}
    ${json_data}    Evaluate    json.dumps(${body})
    ${put_url}    Set Variable    api/studentsDetails/${employee_id}
    ${response}    Put Request    mySession    ${put_url}    headers=${headers}    data=${json_data}
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
    Should Be Equal As Strings    ${response_data[4]['date_of_birth']}    12-12-1996

#Delete Employee Data
#    ${url}    Set Variable    https://thetestingworldapi.com/
#    ${headers}    Create Dictionary    Content-Type    application/json
#
#    # Retrieve the 10th employee's ID
#    ${query_params}    Create Dictionary    limit=10
#    Create Session    mySession    ${url}
#    ${response}    Get On Session    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
#    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
#    ${response_data}    Evaluate    json.loads('''${response_body}''')
#    ${employee_id}    Set Variable    ${response_data[9]['id']}  # Use index 9 for the 10th employee
#
#    Create Session    mySession    ${url}
#    ${response}    Delete On Session    mySession    api/studentsDetails/${employee_id}    headers=${headers}
#    Should Be Equal As Strings    ${response.status_code}    200
#
#    #Check One
#    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
#    ${response_data}    Evaluate    json.loads('''${response_body}''')
#
##    Should Be Equal    true     ${status}
##    Should Be Equal    Delete  data success     ${status}
#
#    Log To Console    ${response_body}

Delete Employee Data
    [Return]    ${deleted_employee_id}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json

    # Retrieve the 10th employee's ID
    ${query_params}    Create Dictionary    limit=10
    Create Session    mySession    ${url}
    ${response}    Get On Session    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    ${employee_id}    Set Variable    ${response_data[9]['id']}  # Use index 9 for the 10th employee
    ${deleted_employee_id}    Set Variable   ${employee_id}
    Create Session    mySession    ${url}
    ${response}    Delete On Session    mySession    api/studentsDetails/${employee_id}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    ${status}    Set Variable    ${response_data['status']}
    ${msg}    Set Variable    ${response_data['msg']}
    ${exp_message}    Set Variable    Delete  data success
    Should Be Equal As Strings    ${status}    true
    Log To Console    ${response_body}
Validate Employee Data after Delete
    [Arguments]    ${employee_id}
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${query_params}    Create Dictionary    id=${employee_id}
    Create Session    mySession    ${url}
    ${response}    Get Request    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')

    # Verify that the employee ID is not present in the response data
#    Run Keyword If    '${response_data}'    Fail    msg=Employee still exists in the response
    Should Not Contain Any    ${response_data}      ${employee_id}
#    Run Keyword If    '${employee_id}' in '${response_data[]}'    Fail    msg=Employee ID still exists in the response

Print All List Of Employees after all Operations
    ${url}    Set Variable    https://thetestingworldapi.com/
    ${headers}    Create Dictionary    Content-Type    application/json
    ${query_params}    Create Dictionary    limit=9
    Create Session    mySession    ${url}
    ${response}    Get On Session    mySession    api/studentsDetails    headers=${headers}    params=${query_params}
    ${response_body}    Set Variable    ${response.content.decode('utf-8')}
    ${response_data}    Evaluate    json.loads('''${response_body}''')
    Log    ${response_body}
