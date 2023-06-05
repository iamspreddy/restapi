*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${repo_owner}    spreddy559
${repo_name}    spreddy1
${file_path}    newemp.json
${github_repo_url}    https://api.github.com/repos/${repo_owner}/${repo_name}/contents/${file_path}
${token}    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


*** Test Cases ***
Add Employee Data to GitHub Repository
    Fetch Latest SHA Value
    Generate Employee Data
#    Add Employee Data to Repository

*** Keywords ***
Fetch Latest SHA Value
    Create Session    github    ${github_repo_url}
    ${headers}    Create Dictionary    Authorization=Bearer ${token}     Accept=application/vnd.github.v3+json
    ${response}    Get Request    github    ${github_repo_url}    headers=${headers}    # Fetch the latest SHA value
    Should Be Equal As Strings    ${response.status_code}    200
#    ${file_info}    Convert To Dictionary    ${response.content}
#    ${sha}    Set Variable If    'sha' in ${file_info}    ${file_info['sha']}    ${EMPTY}
#    Log    SHA Value: ${sha}

Generate Employee Data
    [Return]    ${employee_data}
    ${employee_data}    Create List
    FOR    ${index}    IN RANGE    10
        ${employee}    Create Dictionary    name=${EMPTY}   age=${EMPTY}    gender=${EMPTY}     designation=${EMPTY}
        Append To List    ${employee_data}    ${employee}
    END

    FOR    ${employee}    IN    @{employee_data}
        ${name}    Evaluate    ''.join(random.choice(string.ascii_letters) for _ in range(5))
        ${age}    Set Variable    random.randint(20, 40)
        ${gender}    Evaluate    random.choice(["male", "female"])
        ${designation}    Evaluate    random.choice(["Engineer", "Manager", "Analyst"])
        Set To Dictionary    ${employee}    name    ${name}
        Set To Dictionary    ${employee}    age    ${age}
        Set To Dictionary    ${employee}    gender    ${gender}
        Set To Dictionary    ${employee}    designation    ${designation}
    END

    Log Many    Employee Data: ${employee_data}

Add Employee Data to Repository
    ${employee_data_json}    To JSON    ${employee_data}
    ${encoded_content}    Convert To String    ${employee_data_json}
    ${data}    Create Dictionary    message=Add employee data   content=${encoded_content}  sha=${sha}
    ${headers}    Create Dictionary    Authorization=Bearer ${token}
    ...    Accept=application/vnd.github.v3+json
    ${url}    Set Variable If    '${sha}' != '${EMPTY}'    ${github_repo_url}    ${github_repo_url}?sha=${sha}
    ...    ELSE    ${github_repo_url}
    ${response}    Run Keyword If    '${sha}' != '${EMPTY}'
    ...    Put Request    github    ${url}    headers=${headers}    json=${data}
    ...    ELSE    Post Request    github    ${url}    headers=${headers}    json=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Employee data added successfully to the repository
