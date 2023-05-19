*** Settings ***
Documentation     Example Robot Framework Suite for Reading Employee Data from GitHub and Sending POST Requests
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Library           String
Library           JSONLibrary
Library           GitHubLibrary

*** Variables ***
${BASE_URL}       https://api.example.com
${GITHUB_REPO}    YourGitHubUsername/YourRepoName
${FILE_PATH}      employees.json

*** Test Cases ***
Create Employees
    [Documentation]    Create employees using data from GitHub repository
    ${content}    Get File Content from GitHub    ${GITHUB_REPO}    ${FILE_PATH}
    ${source data}=    Evaluate     json.loads("""${source data}""")    json
    # the variable ${source data} is now a python dictionary - the same as the original json, but only - accessible as dictionary in robotframwork
    ${all data members}=    Set Variable     ${source data['data']}
    ${user_phone}=    Create Dictionary
    ${employees}    Parse JSON    ${content}
    FOR    ${employee}    IN    @{employees}
        Create Employee    ${employee}
    END
    [Teardown]    Delete All Employees

*** Keywords ***
Create Employee
    [Arguments]    ${employee}
    ${headers}    Create Dictionary    Content-Type=application/json
    ${response}    Post Request    ${BASE_URL}/employees    json=${employee}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    Employee created with ID: ${response.json()['id']}

Get File Content from GitHub
    [Arguments]    ${repo}    ${file_path}
    ${response}    Get Repository File    ${repo}    ${file_path}
    Should Be Equal As Strings    ${response.status_code}    200
    ${content}    Get Value From JSON    ${response.content}    content
    ${decoded_content}    Decode Bytes to String    ${content}
    [Return]    ${decoded_content}

Delete All Employees
    ${headers}    Create Dictionary    Content-Type=application/json
    ${response}    Delete Request    ${BASE_URL}/employees    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    204
    Log    All employees deleted
