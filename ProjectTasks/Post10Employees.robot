*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://thetestingworldapi.com/
@{EMPLOYEE_DATA}    Create List
...    {
...        "first_name": "Radha",
...        "middle_name": "krishna",
...        "last_name": "Jale",
           "date_of_birth":"1-1-1991"
...    }
...    {
...        "first_name": "Sangava",
...        "middle_name": "raja",
...        "last_name": "Kale",
           "date_of_birth":"11-12-1995"
...    }
...    {
...        "first_name": "Shyam",
...        "middle_name": "Sundhar",
...        "last_name": "swamy",
           "date_of_birth":"11-10-1996"
...    }
...    {
...        "first_name": "Sangava",
...        "middle_name": "shastri",
...        "last_name": "andra",
           "date_of_birth":"7-2-1992"
...    }
       {
...        "first_name": "Sudha",
...        "middle_name": "krishna",
...        "last_name": "kadapa",
           "date_of_birth":"6-5-1993"
...    }
...    {
...        "first_name": "siddarth",
...        "middle_name": "narayan",
...        "last_name": "jain",
           "date_of_birth":"18-12-1991"
...    }
...    {
...        "first_name": "Shiva",
...        "middle_name": "swamy",
...        "last_name": "Kaladi",
           "date_of_birth":"1-1-1991"
...    }
...    {
...        "first_name": "Shankar",
...        "middle_name": "Rama",
...        "last_name": "Swamy",
           "date_of_birth":"11-10-1996"
...    }
...    {
...        "first_name": "Sagar",
...        "middle_name": "Sadan",
...        "last_name": "Udipi",
           "date_of_birth":"14-06-1998"
...    }
...    {
...        "first_name": "Anandha",
...        "middle_name": "shastri",
...        "last_name": "Rajya",
           "date_of_birth":"17-02-1994"
...    }

*** Test Cases ***
Send POST Request for Employees
    Create Session    My API    ${BASE_URL}
    ${headers}    Create Dictionary    Content-Type    application/json

    FOR    ${employee}    IN    @{EMPLOYEE_DATA}
        ${response}    Post Request    My API    api/studentsDetails    data=${employee}    headers=${headers}
        Log    ${response}
    END
