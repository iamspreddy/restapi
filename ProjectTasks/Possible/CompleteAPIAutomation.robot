*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSON
Library    String

*** Variables ***
${GITHUB_API}               https://api.github.com
${REPO_OWNER}               spreddy559
${REPO_NAME}                restapi
${FILE_PATH}                employees.json
${AUTHORIZATION_TOKEN}      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

*** Test Cases ***
Update JSON Data on GitHub
    Create Session    github    ${GITHUB_API}
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTHORIZATION_TOKEN}
    ${url}=    Catenate    SEPARATOR=/    ${GITHUB_API}    repos    ${REPO_OWNER}    ${REPO_NAME}    contents    ${FILE_PATH}
    ${response}=    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${content}    Set Variable    ${response.json()['content']}
    ${decoded_bytes}    Run Keyword And Ignore Error    Base64 Decode    ${content}
    ${decoded_content_str}=    Decode Bytes To String    ${decoded_bytes[1]}    utf-8
    ${sha}    Set Variable    ${response.json()['sha']}
    Create File    ${OUTPUT_FILE}    ${decoded_content_str}
    Log    File SHA: ${sha}
