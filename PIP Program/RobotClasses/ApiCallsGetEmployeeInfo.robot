*** Settings ***
Library    Requests
Library    OperatingSystem
Library     RequestsLibrary
*** Variables ***
${base_url}     https://www.boredapi.com/api/
${city}     Delhi


*** Test Cases ***
Get some data from the url
    Create Session    mysession     ${base_url}
    ${response}=    GET On Session   mysession    activity/
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}