*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
*** Keywords ***
#Create Employee Data
#    [Return]    ${employees}
#    ${employees}  Create List
#...  {
#...    "id": 1,
#...    "first_name": "John",
#...    "middle_name": "Doe",
#...    "last_name": "Smith",
#...    "date_of_birth": "1990-01-01"
#...  }
#...  {
#...    "id": 2,
#...    "first_name": "Jane",
#...    "middle_name": "Mary",
#...    "last_name": "Johnson",
#...    "date_of_birth": "1995-05-15"
#...  }
#...  {
#...    "id": 3,
#...    "first_name": "Michael",
#...    "middle_name": "",
#...    "last_name": "Brown",
#...    "date_of_birth": "1988-09-30"
#...  }
#...  {
#...    "id": 4,
#...    "first_name": "Emily",
#...    "middle_name": "Anne",
#...    "last_name": "Davis",
#...    "date_of_birth": "1992-07-20"
#...  }
#...  {
#...    "id": 5,
#...    "first_name": "David",
#...    "middle_name": "Robert",
#...    "last_name": "Wilson",
#...    "date_of_birth": "1993-03-10"
#...  }
#...  {
#...    "id": 6,
#...    "first_name": "Sarah",
#...    "middle_name": "",
#...    "last_name": "Lee",
#...    "date_of_birth": "1991-12-05"
#...  }
#...  {
#...    "id": 7,
#...    "first_name": "Daniel",
#...    "middle_name": "James",
#...    "last_name": "Taylor",
#...    "date_of_birth": "1989-04-18"
#...  }
#...  {
#...    "id": 8,
#...    "first_name": "Olivia",
#...    "middle_name": "Grace",
#...    "last_name": "Anderson",
#...    "date_of_birth": "1994-08-25"
#...  }
#...  {
#...    "id": 9,
#...    "first_name": "William",
#...    "middle_name": "Thomas",
#...    "last_name": "Clark",
#...    "date_of_birth": "1998-02-12"
#...  }
#...  {
#...    "id": 10,
#...    "first_name": "Sophia",
#...    "middle_name": "Elizabeth",
#...    "last_name": "Brown",
#...    "date_of_birth": "1996-06-28"
#...  }

*** Variables ***
${url}      https://thetestingworldapi.com/
#${employees}  Create List
#...  {
#...    "id": 1,
#...    "first_name": "John",
#...    "middle_name": "Doe",
#...    "last_name": "Smith",
#...    "date_of_birth": "1990-01-01"
#...  }
#...  {
#...    "id": 2,
#...    "first_name": "Jane",
#...    "middle_name": "Mary",
#...    "last_name": "Johnson",
#...    "date_of_birth": "1995-05-15"
#...  }
#...  {
#...    "id": 3,
#...    "first_name": "Michael",
#...    "middle_name": "",
#...    "last_name": "Brown",
#...    "date_of_birth": "1988-09-30"
#...  }
#...  {
#...    "id": 4,
#...    "first_name": "Emily",
#...    "middle_name": "Anne",
#...    "last_name": "Davis",
#...    "date_of_birth": "1992-07-20"
#...  }
#...  {
#...    "id": 5,
#...    "first_name": "David",
#...    "middle_name": "Robert",
#...    "last_name": "Wilson",
#...    "date_of_birth": "1993-03-10"
#...  }
#...  {
#...    "id": 6,
#...    "first_name": "Sarah",
#...    "middle_name": "",
#...    "last_name": "Lee",
#...    "date_of_birth": "1991-12-05"
#...  }
#...  {
#...    "id": 7,
#...    "first_name": "Daniel",
#...    "middle_name": "James",
#...    "last_name": "Taylor",
#...    "date_of_birth": "1989-04-18"
#...  }
#...  {
#...    "id": 8,
#...    "first_name": "Olivia",
#...    "middle_name": "Grace",
#...    "last_name": "Anderson",
#...    "date_of_birth": "1994-08-25"
#...  }
#...  {
#...    "id": 9,
#...    "first_name": "William",
#...    "middle_name": "Thomas",
#...    "last_name": "Clark",
#...    "date_of_birth": "1998-02-12"
#...  }
#...  {
#...    "id": 10,
#...    "first_name": "Sophia",
#...    "middle_name": "Elizabeth",
#...    "last_name": "Brown",
#...    "date_of_birth": "1996-06-28"
#...  }

*** Test Cases ***
Post Employees Data
    Create Session    mySession     ${url}
    ${headers}    Create Dictionary    User-Agent=python-requests/2.28.2    Accept-Encoding=gzip, deflate    Accept=*/*    Connection=keep-alive    Content-Type=application/json
    ${body}    Create List
    ...    { "id": 1, "first_name": "John", "middle_name": "Doe", "last_name": "Smith", "date_of_birth": "1990-01-01" }
    ...    { "id": 2, "first_name": "Jane", "middle_name": "Mary", "last_name": "Johnson", "date_of_birth": "1995-05-15" }
    ...    { "id": 3, "first_name": "Michael", "middle_name": "", "last_name": "Brown", "date_of_birth": "1988-09-30" }
    ...    { "id": 4, "first_name": "Emily", "middle_name": "Anne", "last_name": "Davis", "date_of_birth": "1992-07-20" }
    ...    { "id": 5, "first_name": "David", "middle_name": "Robert", "last_name": "Wilson", "date_of_birth": "1993-03-10" }
    ...    { "id": 6, "first_name": "Sarah", "middle_name": "", "last_name": "Lee", "date_of_birth": "1991-12-05" }
    ...    { "id": 7, "first_name": "Daniel", "middle_name": "James", "last_name": "Taylor", "date_of_birth": "1989-04-18" }
    ...    { "id": 8, "first_name": "Olivia", "middle_name": "Grace", "last_name": "Anderson", "date_of_birth": "1994-08-25" }
    ...    { "id": 9, "first_name": "William", "middle_name": "Thomas", "last_name": "Clark", "date_of_birth": "1998-02-12" }
    ...    { "id": 10, "first_name": "Sophia", "middle_name": "Elizabeth", "last_name": "Brown", "date_of_birth": "1996-06-28" }
    ${response}    POST On Session    mySession    ${url}    json=${body}    headers=${headers}
    Log    ${response.status_code}
    Log    ${response.content}
