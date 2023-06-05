*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    BuiltIn
Library    OperatingSystem
Library    JSON

*** Variables ***
${GITHUB_API}             https://api.github.com
${REPO_OWNER}             spreddy559
${REPO_NAME}              restapi
${FILE_PATH}              employees1.json
${AUTHORIZATION_TOKEN}    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

*** Test Cases ***
Update and Delete Employees
    # Create session and perform GET request to retrieve file content
    Create Session    github    ${GITHUB_API}
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTHORIZATION_TOKEN}
    ${get_response}=    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${current_content}=    Evaluate    json.loads($get_response.content)['content']
    ${current_sha}=    Evaluate    json.loads($get_response.content)['sha']

    # Decode the current content and update the designation of the 5th employee
    ${decoded_content}=    Evaluate    base64.b64decode($current_content.encode("utf-8")).decode("utf-8")
    ${json_data}=    Evaluate    json.loads($decoded_content)
    ${before_update_data}=    Set Variable    ${json_data[4]}
    ${updated_designation}=    Set Variable    Software
    Set To Dictionary    ${before_update_data}    designation=${updated_designation}

    # Encode the updated JSON data
    ${updated_content}=    Evaluate    base64.b64encode(json.dumps($json_data).encode("utf-8")).decode("utf-8")

    # Create the payload with the updated content and SHA value
    ${put_payload}=    Create Dictionary    path=${FILE_PATH}    message=Update designation    content=${updated_content}    sha=${current_sha}

    # Send the PUT request to update the file with the updated designation
    ${put_response}=    Put Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}    json=${put_payload}

    # Verify the response status code
    Should Be Equal As Strings    ${put_response.status_code}    200

    # Get the employee data after designation update
    ${get_response}=    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${updated_content}=    Evaluate    json.loads($get_response.content)['content']
    ${decoded_content}=    Evaluate    base64.b64decode($updated_content.encode("utf-8")).decode("utf-8")
    ${updated_json_data}=    Evaluate    json.loads($decoded_content)
    ${after_update_data}=    Set Variable    ${updated_json_data[4]}

    # Verify if the designation is updated by comparing before and after employee data
    ${is_designation_updated}=    Should Be Equal As Strings    ${before_update_data["designation"]}    ${after_update_data["designation"]}
    Run Keyword If    '${is_designation_updated}'=='False'    Fail    The designation of the 5th employee is not updated

    # Perform DELETE request to remove the 10th employee
    ${delete_payload}=    Create Dictionary    message=Delete employee    sha=${current_sha}
    ${delete_response}=    DELETE On Session    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}    json=${delete_payload}

    # Verify the response status code
    Should Be Equal As Strings    ${delete_response.status_code}    200
    Log To Console    ${delete_response.content}

    # Get the employee data after deletion
    ${get_response}=    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${deleted_content}=    Evaluate    json.loads($get_response.content)['content']
    ${decoded_deleted_content}=    Evaluate    base64.b64decode($deleted_content.encode("utf-8")).decode("utf-8")
    ${deleted_json_data}=    Evaluate    json.loads($decoded_deleted_content)
    ${deleted_employee_data}=    Set Variable    ${deleted_json_data[9]}

    # Verify if the employee data is deleted by comparing with the deleted employee data
    ${is_employee_deleted}=    Should Not Be True    ${deleted_employee_data}    ${updated_json_data}
    Run Keyword If    not ${is_employee_deleted}    Fail    The 10th employee is not deleted

    # Print the final decoded content
    Log Many    Final Decoded Content:    ${updated_json_data}



