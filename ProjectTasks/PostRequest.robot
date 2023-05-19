*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${url}      https://thetestingworldapi.com
@{EMPLOYEE_DATA}    Create List
    {
        "name": "Rama",
        "age": "23",
        "gender": "male"
    }
    {
        "name": "Beema",
        "age": "25",
        "gender": "male"
    }
    {
        "name": "Seetha",
        "age": "21",
        "gender": "Female"
    }
    {
        "name": "Geetha",
        "age": "26",
        "gender": "male"
    }
    {
        "name": "Ramesh",
        "age": "33",
        "designation": "softwareEngineer",
        "gender": "male"
    }
    {
        "name": "Raghava",
        "age": "23",
        "gender": "male"
    }
    {
        "name": "Jawahar",
        "age": "29",
        "gender": "male"
    }
    {
        "name": "Ravi",
        "age": "33",
        "gender": "male"
    }
    {
        "name": "Dhoni",
        "age": "38",
        "gender": "male"
    }
    {
        "name": "Sagar",
        "age": "28",
        "gender": "male"
    }
*** Test Cases ***

Get 10 Employees data
     Create Session    mysession     ${url}
     ${response}=    Get Request    mysession  api/studentDetails
     Log     ${response.status_code}
Send 10 Employees data
#     Create Session    mysession     ${url}
#     ${body}=   Create Dictionary    first_name=sp   middle_name=dhoni   last_name=dhoni    date_of_birth=03/04/1996
#     ${header}=     Create Dictionary     Content-Type     application/json
#     ${response}=    Post Request    mysession  /api/studentsDetails     json=${body}     headers=${header}
#     ${code}=   Convert To String    ${response.status_code}
#     Log To Console     ${response.content}
#     Log     ${response.status_code}

#    Create Session    My API    https://thetestingworldapi.com
#    ${headers}    Create Dictionary    Content-Type    application/json
#    ${payload}    Create Dictionary    name=John Doe    age=25    email=johndoe@example.com
#    ${response}    Post Request    My API    /api/studentsDetails    json=${payload}    headers=${headers}
#    Log    ${response}
#    Log To Console     ${response.content}
#    Log     ${response.status_code}

    Create Session    My API    ${url}
    ${headers}    Create Dictionary    Content-Type    application/json

    FOR    ${employee}    IN    @{EMPLOYEE_DATA}
        ${response}    Post Request    My API    /api/studentsDetails    json=${employee}    headers=${headers}
        Log    ${response}
    END