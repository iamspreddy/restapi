*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
${GITHUB_API}    https://api.github.com
${REPO_OWNER}    spreddy559
${REPO_NAME}     restapi
${FILE_PATH}     employees.json
${AUTHORIZATION_TOKEN}   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
${OUTPUT_FILE}   ${CURDIR}/emp.json
*** Test Cases ***
CheckSession things
    Create Session  Alias  ${GITHUB_API}

    ${file_data}  Get File  ${OUTPUT_FILE}
    ${files}  Create Dictionary  emp.json  ${file_data}  dataType=json
#    ${data}  Create Dictionary   inputFileTypeId=1  dataType=json
    Set to Dictionary   ${files}
    Log  ${files}
    ${resp}  RequestsLibrary.Post Request  ALias  /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    files=${files}
    Log  ${resp}
    Should Be Equal As Strings  ${resp.status_code}   201