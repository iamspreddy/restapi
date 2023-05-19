*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${url}      https://thetestingworldapi.com/
${response_list}    Create List

*** Test Cases ***
Add One Employee Data
    Create Session    mySession        ${url}
    ${header}   Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1992-12-01
    ${response}=    Post Request    mySession   api/employees    data=${body}   headers=${header}
    Log To Console    ${response}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    Log     ${response.content}
    Append To List    ${response_list}    ${response.content}

    ${body}=    Create Dictionary    first_name=Ganesha  middle_name=vinayaka  last_name=shiva    date_of_birth=1992-12-01
    ${response}=    Post Request    mySession   api/employees    data=${body}   headers=${header}
    Log To Console    ${response}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    Log     ${response.content}
    Append To List    ${response_list}    ${response.content}

    Log To Console    ${response_list}
