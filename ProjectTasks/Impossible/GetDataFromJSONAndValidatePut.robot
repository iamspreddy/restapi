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
Update File on GitHub
    # Get the current file contents from GitHub
    Create Session    github    ${GITHUB_API}
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTHORIZATION_TOKEN}
    ${get_response}    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${current_content}    Evaluate    json.loads($get_response.content)['content']
    ${current_sha}    Evaluate    json.loads($get_response.content)['sha']

    # Decode the current content and update the "employee designation" field
    ${decoded_content}    Evaluate    base64.b64decode($current_content.encode("utf-8")).decode("utf-8")
    ${json_data}    Evaluate    json.loads($decoded_content)

  # Update the designation of the 5th employee
    Set To Dictionary    ${json_data}[4]    designation    Manager



    # Encode the updated JSON data
    ${updated_content}    Evaluate    base64.b64encode(json.dumps($json_data).encode("utf-8")).decode("utf-8")

    # Create the payload with the updated content and SHA value
    ${payload}    Create Dictionary    path=${FILE_PATH}    message=Update employee designation    content=${updated_content}    sha=${current_sha}

    # Send the PUT request to update the file
    ${put_response}    Put Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}    json=${payload}

    # Verify the response status code
    Should Be Equal As Strings    ${put_response.status_code}    200




    # Validate whether the 10th employee is deleted
    ${get_response}    Get Request    github    /repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}    headers=${headers}
    ${updated_content}    Evaluate    json.loads($get_response.content)['content']
    ${decoded_content}    Evaluate    base64.b64decode($updated_content.encode("utf-8")).decode("utf-8")
    ${updated_json_data}    Evaluate    json.loads($decoded_content)

    ${employee_count}    Get Length    ${updated_json_data}
    ${is_employee_deleted}    Run Keyword And Return Status    Should Not Be Equal As Strings    ${employee_count}    10
    Run Keyword Unless    ${is_employee_deleted}    Fail    The 10th employee is not deleted


     # Check if the 10th employee is available
    ${is_10th_employee_available}    Run Keyword And Return Status    Value Should Exist    ${json_data[9]}

    # Delete the 10th employee if available
    Run Keyword If    ${is_10th_employee_available}    Delete Employee    ${json_data[9]}

    # Validate whether the 10th employee is deleted
    ${is_employee_deleted}    Run Keyword And Return Status    Value Should Not Exist    ${json_data[9]}
    Run Keyword Unless    ${is_employee_deleted}    Fail    The 10th employee is not deleted

    # Print the latest content
    Log    Latest Content: ${updated_json_data}
