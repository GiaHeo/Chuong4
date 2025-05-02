*** Settings ***
Documentation    Page Object cho trang đăng nhập OrangeHRM
Library    SeleniumLibrary

*** Variables ***
${LOGIN_USERNAME_FIELD}    css:input[name="username"]
${LOGIN_PASSWORD_FIELD}    css:input[name="password"]
${LOGIN_BUTTON}            css:button[type="submit"]
${ERROR_MESSAGE}           css:.oxd-alert-content-text
${REQUIRED_ERROR}          xpath://span[contains(text(), 'Required')]
${USERNAME_REQUIRED_ERROR} xpath://div[@class='oxd-form-row'][1]//span[contains(text(), 'Required')]
${PASSWORD_REQUIRED_ERROR} xpath://div[@class='oxd-form-row'][2]//span[contains(text(), 'Required')]
${DASHBOARD_TITLE}         css:.oxd-topbar-header-title

*** Keywords ***
Mở trang đăng nhập
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_USERNAME_FIELD}    timeout=10s
    Title Should Be    OrangeHRM

Nhập tên đăng nhập
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_FIELD}    timeout=10s
    Input Text    ${LOGIN_USERNAME_FIELD}    ${username}

Nhập mật khẩu
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${LOGIN_PASSWORD_FIELD}    timeout=10s
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}

Nhấn nút đăng nhập
    Click Button    ${LOGIN_BUTTON}

Kiểm tra đăng nhập thành công
    Wait Until Element Is Visible    ${DASHBOARD_TITLE}    timeout=10s
    Page Should Contain Element    ${DASHBOARD_TITLE}
    Element Should Contain    ${DASHBOARD_TITLE}    Dashboard

Kiểm tra thông báo đăng nhập thất bại
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=10s
    Page Should Contain Element    ${ERROR_MESSAGE}
    Element Should Contain    ${ERROR_MESSAGE}    Invalid credentials

Kiểm tra lỗi trường bắt buộc
    Wait Until Page Contains Element    ${REQUIRED_ERROR}    timeout=10s
    Page Should Contain Element    ${REQUIRED_ERROR}

Kiểm tra lỗi tên đăng nhập bắt buộc
    Wait Until Page Contains Element    ${USERNAME_REQUIRED_ERROR}    timeout=10s
    Page Should Contain Element    ${USERNAME_REQUIRED_ERROR}

Kiểm tra lỗi mật khẩu bắt buộc
    Wait Until Page Contains Element    ${PASSWORD_REQUIRED_ERROR}    timeout=10s
    Page Should Contain Element    ${PASSWORD_REQUIRED_ERROR}
