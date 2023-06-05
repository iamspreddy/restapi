*** Settings ***
Library    String
Library    OperatingSystem
Library    RequestsLibrary
Library    Collections

*** Variables ***
${json_file}    ${CURDIR}/employees.json
${content}      ${EMPTY}
${encoded_content}    ${EMPTY}
${base_url}    https://api.github.com
${repo_owner}    spreddy559
${repo_name}    spreddy1
${file_path}    /repos/${repo_owner}/${repo_name}/contents/newemp.json?ref=main
${access_token}    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

*** Test Cases ***
Send POST Request with Encoded Content
    ${content}=    Get File Content    ${json_file}
    ${encoded_content}=    Evaluate    base64.b64encode('''${content}'''.encode('utf-8')).decode('utf-8')
    Log    Encoded Content: ${encoded_content}
    Delete All Sessions
    Create Session    github    ${base_url}
    ${headers}=    Create Dictionary    User-Agent=python-requests/2.28.2    Accept-Encoding=gzip, deflate    Accept=application/vnd.github.v3+json    Connection=keep-alive    Authorization=Bearer ${access_token}    Content-Type=application/vnd.github.object       X-GitHub-Api-Version=2022-11-28
    ${body}=    Create Dictionary    message=Add employee data    content=${encoded_content}    encoding=base64
    ${response}=    Post Request    github    ${file_path}    headers=${headers}    data=${body}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    POST Request Response: ${response.content}

*** Keywords ***
Get File Content
    [Arguments]    ${file_path}
    ${content}=    Run and Return Rc    cat ${file_path}
    [Return]    ${content}
