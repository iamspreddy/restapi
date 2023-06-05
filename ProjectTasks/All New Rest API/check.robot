*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSON
Library    String


*** Variables ***
${GITHUB_API}    https://api.github.com
${REPO_OWNER}    spreddy559
${REPO_NAME}     spreddy1
${FILE_PATH}     newemp.json
${AUTHORIZATION_TOKEN}   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
${OUTPUT_FILE}   ${CURDIR}/employees.json

*** Test Cases ***
Create employee data using the POST method Create 10 employees data
    ${file_content}    Get File    ${OUTPUT_FILE}
    ${parsed_data}    Evaluate    json.loads('''${file_content}''')
    ${id}          Set Variable    ${parsed_data[0]['id']}
    ${name}          Set Variable    ${parsed_data[0]['name']}
    ${department}    Set Variable    ${parsed_data[0]['department']}
    ${employee_data}    Create Dictionary    id=${id}    name= ${name}    department=${department}
    ${employee_data_json}    Convert Dictionary to JSON    ${employee_data}
    ${payload}    Create Dictionary    message=Add employee data    content=${employee_data_json}
    ${headers}    Create Dictionary    Authorization=Bearer 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    Accept=application/vnd.github.v3+json    Content-Type=application/json
    Create Session    newgithub    ${GITHUB_API}
    ${response}    Post Request    newgithub    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}?ref=main    json=${payload}    headers=${headers}
    Log    ${response}
    Log    ${response.content}

Create or Update File on GitHub
    ${url}    Set Variable    https://api.github.com/repos/spreddy559/spreddy1/contents/newemp.json?ref=main
    ${headers}    Create Dictionary    User-Agent=python-requests/2.28.2    Accept-Encoding=gzip, deflate    Accept=application/vnd.github.v3+json    Connection=keep-alive    Authorization=Bearer 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    Content-Type=application/json
        ${body}    Create Dictionary    message=Add employee data    content=Cg==   # Base64 encoded content
    ${response}    Post Request    ${url}    headers=${headers}    json=${body}
    Should Be Equal As Strings    ${response.status_code}    201    # Check if the request was successful
    Log    File created or updated successfully on GitHub

*** Keywords ***
Base64 Decode
    [Arguments]    ${content}
    ${decoded_bytes}    Evaluate    base64.b64decode('''${content}''')
    [Return]    ${decoded_bytes}

Convert Dictionary to JSON
    [Arguments]    ${dictionary}
    ${json_string}    Evaluate    json.dumps(${dictionary})
    [Return]    ${json_string}