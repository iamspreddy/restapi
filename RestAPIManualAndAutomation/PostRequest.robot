*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
*** Keywords ***

*** Variables ***
${url}      https://thetestingworldapi.com/
${employees}  Create List
...  {
...    "id": 1,
...    "first_name": "John",
...    "middle_name": "Doe",
...    "last_name": "Smith",
...    "date_of_birth": "1990-01-01"
...  }
...  {
...    "id": 2,
...    "first_name": "Jane",
...    "middle_name": "Mary",
...    "last_name": "Johnson",
...    "date_of_birth": "1995-05-15"
...  }
...  {
...    "id": 3,
...    "first_name": "Michael",
...    "middle_name": "",
...    "last_name": "Brown",
...    "date_of_birth": "1988-09-30"
...  }
...  {
...    "id": 4,
...    "first_name": "Emily",
...    "middle_name": "Anne",
...    "last_name": "Davis",
...    "date_of_birth": "1992-07-20"
...  }
...  {
...    "id": 5,
...    "first_name": "David",
...    "middle_name": "Robert",
...    "last_name": "Wilson",
...    "date_of_birth": "1993-03-10"
...  }
...  {
...    "id": 6,
...    "first_name": "Sarah",
...    "middle_name": "",
...    "last_name": "Lee",
...    "date_of_birth": "1991-12-05"
...  }
...  {
...    "id": 7,
...    "first_name": "Daniel",
...    "middle_name": "James",
...    "last_name": "Taylor",
...    "date_of_birth": "1989-04-18"
...  }
...  {
...    "id": 8,
...    "first_name": "Olivia",
...    "middle_name": "Grace",
...    "last_name": "Anderson",
...    "date_of_birth": "1994-08-25"
...  }
...  {
...    "id": 9,
...    "first_name": "William",
...    "middle_name": "Thomas",
...    "last_name": "Clark",
...    "date_of_birth": "1998-02-12"
...  }
...  {
...    "id": 10,
...    "first_name": "Sophia",
...    "middle_name": "Elizabeth",
...    "last_name": "Brown",
...    "date_of_birth": "1996-06-28"
...  }
${body3}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1/12/1992
${body4}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1/12/1992
${my_list}=    Create List
*** Test Cases ***
Add one Employee data
    Create Session    mySession        ${url}
    ${header}   Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1/12/1992
    ${response}=    Post Request    mySession   api/studentsDetails     data=${body}   headers=${header}
    Log To Console    ${response}
    ${status_code}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status_code}   201
    ${content}=      Get Variable Value       ${response.content.decode('utf-8')}
    ${content}=     Set Variable    ${content}
    Append To List    ${my_list}    ${content}
    Log To Console    ${my_list}

    ${body}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1/12/1992
    ${response}=    Post Request    mySession   api/studentsDetails     data=${body}   headers=${header}
    Log To Console    ${response}
    ${status_code}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status_code}   201
    ${content}=      Get Variable Value       ${response.content.decode('utf-8')}
    ${content}=     Set Variable    ${content}
    Append To List    ${my_list}    ${content}
    Log To Console      ${my_list}

