*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSON
Library    String


*** Variables ***
${GITHUB_API}    https://api.github.com
${REPO_OWNER}    spreddy559
${REPO_NAME}     restapi
${FILE_PATH}     employees.json
${AUTHORIZATION_TOKEN}   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
${OUTPUT_FILE}   ${CURDIR}/employees.json

*** Test Cases ***
Get File From GitHub
    Create Session    github    ${GITHUB_API}
    ${response}    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}
    Log    ${response}
    ${content}    Set Variable    ${response.json()['content']}
    ${decoded_bytes}    Run Keyword And Ignore Error    Base64 Decode    ${content}
    ${decoded_content_str}=    Decode Bytes To String    ${decoded_bytes[1]}    utf-8
    Create File    ${OUTPUT_FILE}    ${decoded_content_str}
    Delete All Sessions

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
    ${response}    Post Request    newgithub    /repos/${REPO_OWNER}/${NEW_REPO_NAME}/contents/${NEW_FILE_PATH}    json=${payload}    headers=${headers}
    Log    ${response}
    Log    ${response.content}


*** Keywords ***
Base64 Decode
    [Arguments]    ${content}
    ${decoded_bytes}    Evaluate    base64.b64decode('''${content}''')
    [Return]    ${decoded_bytes}

Convert Dictionary to JSON
    [Arguments]    ${dictionary}
    ${json_string}    Evaluate    json.dumps(${dictionary})
    [Return]    ${json_string}