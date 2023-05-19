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
${OUTPUT_FILE}   ${CURDIR}/employees.json

*** Keywords ***
Base64 Decode
    [Arguments]    ${content}
    ${decoded_bytes}    Evaluate    base64.b64decode('''${content}''')
    [Return]    ${decoded_bytes}

*** Test Cases ***
Get File From GitHub
    Create Session    github    ${GITHUB_API}
    ${response}    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}
    Log    ${response}

    ${content}    Set Variable    ${response.json()['content']}
    ${decoded_bytes}    Run Keyword And Ignore Error    Base64 Decode    ${content}
    ${decoded_content_str}=    Decode Bytes To String    ${decoded_bytes[1]}    utf-8
    Create File    ${OUTPUT_FILE}    ${decoded_content_str}

