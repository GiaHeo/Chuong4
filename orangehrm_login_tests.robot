*** Settings ***
Documentation     Test cases for OrangeHRM login functionality
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}        chrome
${VALID_USERNAME}    Admin
${VALID_PASSWORD}    admin123
${INVALID_USERNAME}    WrongUser
${INVALID_PASSWORD}    WrongPassword

*** Test Cases ***
Valid Login
    Input Username    ${VALID_USERNAME}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Dashboard Page Should Be Open
    
Invalid Login With Incorrect Password
    Input Username    ${VALID_USERNAME}
    Input Password    ${INVALID_PASSWORD}
    Submit Credentials
    Error Message Should Be Displayed
    
Invalid Login With Incorrect Username
    Input Username    ${INVALID_USERNAME}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Error Message Should Be Displayed

Login With Empty Credentials
    Input Username    ${EMPTY}
    Input Password    ${EMPTY}
    Submit Credentials
    Required Fields Error Should Be Displayed

Login With Empty Username
    Input Username    ${EMPTY}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Required Username Error Should Be Displayed

Login With Empty Password
    Input Username    ${VALID_USERNAME}
    Input Password    ${EMPTY}
    Submit Credentials
    Required Password Error Should Be Displayed

Multiple Failed Login Attempts
    [Documentation]    Test multiple failed login attempts
    [Setup]    Open Browser To Login Page
    FOR    ${index}    IN RANGE    3
        Input Username    ${INVALID_USERNAME}
        Input Password    ${INVALID_PASSWORD}
        Submit Credentials
        Error Message Should Be Displayed
    END
    # On the third attempt, we should still see the error message
    Error Message Should Be Displayed
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css:input[name="username"]    timeout=10s
    Title Should Be    OrangeHRM

Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    css:input[name="username"]    timeout=10s
    Input Text    css:input[name="username"]    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    css:input[name="password"]    timeout=10s
    Input Text    css:input[name="password"]    ${password}

Submit Credentials
    Click Button    css:button[type="submit"]

Dashboard Page Should Be Open
    Wait Until Element Is Visible    css:.oxd-topbar-header-title    timeout=10s
    Page Should Contain Element    css:.oxd-topbar-header-title
    Element Should Contain    css:.oxd-topbar-header-title    Dashboard

Error Message Should Be Displayed
    Wait Until Element Is Visible    css:.oxd-alert-content-text    timeout=10s
    Page Should Contain Element    css:.oxd-alert-content-text
    Element Should Contain    css:.oxd-alert-content-text    Invalid credentials

Required Fields Error Should Be Displayed
    Wait Until Page Contains Element    xpath://span[contains(text(), 'Required')]    timeout=10s
    Page Should Contain Element    xpath://span[contains(text(), 'Required')]

Required Username Error Should Be Displayed
    Wait Until Page Contains Element    xpath://div[@class='oxd-form-row'][1]//span[contains(text(), 'Required')]    timeout=10s
    Page Should Contain Element    xpath://div[@class='oxd-form-row'][1]//span[contains(text(), 'Required')]

Required Password Error Should Be Displayed
    Wait Until Page Contains Element    xpath://div[@class='oxd-form-row'][2]//span[contains(text(), 'Required')]    timeout=10s
    Page Should Contain Element    xpath://div[@class='oxd-form-row'][2]//span[contains(text(), 'Required')]
