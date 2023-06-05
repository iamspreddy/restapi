*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary

*** Test Cases ***
Send POST Request with Employees
    ${data}    Create List
    FOR    ${index}    IN RANGE    1    11    # Generate data for 10 employees
        ${employee}    Create Dictionary
        Set To Dictionary    ${employee}    id    ${index}
        Set To Dictionary    ${employee}    username    shyam${index}
        Set To Dictionary    ${employee}    name    Singa
        Set To Dictionary    ${employee}    email    roy@example.net
        Set To Dictionary    ${employee}    gender    Male
        Set To Dictionary    ${employee}    designation    Software
        Set To Dictionary    ${employee}    phone_number    5632425246
        Set To Dictionary    ${employee}    complete_address    298 Edythe Harbors Suite 697\nLake Mathiasburgh, MN 25435-6433
        Append To List    ${data}    ${employee}
    END

    ${json_data}    Evaluate    json.dumps(${data})

    ${headers}    Create Dictionary    Content-Type=application/json
    ${url}    Set Variable    https://api.onlinewebtutorblog.com

    # Send POST request to create employees
    Create Session    mySession     ${url}
    ${post_response}    Post Request    mySession   /employees    json=${json_data}    headers=${headers}
    Log    ${post_response.text}

    # Send GET request to retrieve employees and validate the data
    ${get_response}    Get Request    mySession    /employees
    Log    ${get_response.text}
    ${response_data}    Set Variable    ${get_response.json()}
    ${validation_result}    Run Keyword And Return Status    List Should Contain Value    ${response_data}    ${json_data}
    Should Be True    ${validation_result}
