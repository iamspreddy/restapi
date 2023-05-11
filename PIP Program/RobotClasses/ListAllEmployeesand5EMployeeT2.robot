*** Settings ***
Library    Requests
Library    OperatingSystem
Library     RequestsLibrary
*** Variables ***
${base_url}     https://www.boredapi.com/api/



*** Test Cases ***
create employee data using the POST method. Create 10 employees' data
    Create Session    mysession     ${base_url}
    ${response}=    POST On Session      mysession    /add/employeedata
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}