*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library     ScreenCapLibrary
*** Variables ***
${browser}      chrome
${url}      https://login.yahoo.com/?.src=ym&pspid=159600001&activity=mail-direct&.lang=en-IN&.intl=in&.done=https%3A%2F%2Fin.mail.yahoo.com%2Fd

*** Test Cases ***
Record Test Cases
    Start Video Recording      alias=spreddy    name="automationrecording"    fps=6    size_percentage=1   embed=True  embed=100px   monitor=1
    open browser    ${url}      ${browser}
    maximize browser window
    sleep   2s
    input text      xpath=//*[@id="login-username"]     kalyanpavanteja35
    sleep   2s
    Stop Video Recording    alias=spreddy
Send Automation Report
    ${recipient}    Set Variable    purushothama.reddy@terralogic.com
    ${subject}      Set Variable    Final Automation Report
    ${body}         Set Variable    This is the final automation report.
    ${attachment}   Set Variable    ${CURDIR}/automation_report.pdf
    Run Keyword  Send Email  ${recipient}  ${subject}  ${body}  ${attachment}

*** Keywords ***
Send Email
    [Arguments]    ${recipient}    ${subject}    ${body}    ${attachment}
    ${cmd}         Set Variable    echo "${body}" | mail -s "${subject}" -A "${attachment}" ${recipient}
    Run    ${cmd}