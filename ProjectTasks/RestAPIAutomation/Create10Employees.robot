*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://thetestingworldapi.com/

*** Test Cases ***
Create Employee Data
    Create Session    mySession     ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json    Content-Length=560
    ${data}=    Create Employees Data
    ${response}=    Post Request    mySession   api/studentsDetails    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    Employee data created successfully

*** Keywords ***
Robot framework report post suite run



Create Employees Data
    ${data}=    Create List
    FOR    ${index}    IN RANGE    10
        ${employee}=    Create Employee
        Append To List    ${data}    ${employee}
    END
    [Return]    ${data}

Create Employee
    [Return]    name=John Doe    age=30    title=Software Engineer
