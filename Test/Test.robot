*** Settings ***
Resource                 ../Resource/common.robot
Library                  SeleniumLibrary
Library                  OperatingSystem
Library                  ExcelLibrary
Suite Setup              Setup Browser
Suite Teardown           Close All Browsers
Test Template            Example Test

*** Variables ***
${CSV File}              leadP22.csv

*** Test Cases ***
Example Test
    ${data}=    Read Excel Row    ${CSV File}
    FOR    ${row}    IN    @{data}
        ${Last_Name}    ${Company}    ${Lead_Status}=    Set Variable    ${row}
        Log    Testing with Last Name: ${Last_Name} and Company: ${Company}
        Run Keyword    Example Test    ${Last_Name}    ${Company}    ${Lead_Status}
    END

*** Keywords ***
Example Test
    [Arguments]    ${Last_Name}    ${Company}    ${Lead_Status}
    [tags]    Lead
    Open Browser    https://www.salesforce.com    chrome
    Click Text    Leads
    Verify Text    Recently Viewed    timeout=120s
    Click Text    New
    Verify Text    Lead Information
    Type Text    Last Name    ${Last_Name}
    Type Text    Company    ${Company}
    Type Text    Lead Status    ${Lead_Status}
    Click Text    Save    partial_match=False
    Sleep    1
