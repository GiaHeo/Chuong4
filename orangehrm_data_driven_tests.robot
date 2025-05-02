*** Settings ***
Documentation     Kiểm thử trang đăng nhập OrangeHRM sử dụng phương pháp Data-Driven Testing
Resource          page_objects/login_page.robot
Test Setup        Mở trang đăng nhập    ${URL}    ${BROWSER}
Test Teardown     Close All Browsers
Test Template     Kiểm tra thông tin đăng nhập

*** Variables ***
${URL}                https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}            chrome

*** Test Cases ***              USERNAME        PASSWORD        STATUS
Đăng nhập thành công            Admin          admin123        success
Đăng nhập với mật khẩu sai      Admin          wrong_password  failure
Đăng nhập với username sai      wronguser      admin123        failure
Đăng nhập với cả hai sai        wronguser      wrong_password  failure
Đăng nhập với username trống    ${EMPTY}       admin123        required
Đăng nhập với mật khẩu trống    Admin          ${EMPTY}        required
Đăng nhập với cả hai trống      ${EMPTY}       ${EMPTY}        required
Đăng nhập với chữ hoa           ADMIN          admin123        failure
Đăng nhập với username đặc biệt Admin@123      admin123        failure
Đăng nhập với username XSS      <script>alert  admin123        failure

*** Keywords ***
Kiểm tra thông tin đăng nhập
    [Arguments]    ${username}    ${password}    ${status}
    Nhập tên đăng nhập    ${username}
    Nhập mật khẩu        ${password}
    Nhấn nút đăng nhập
    Kiểm tra kết quả đăng nhập    ${status}

Kiểm tra kết quả đăng nhập
    [Arguments]    ${status}
    Run Keyword If    '${status}' == 'success'    Kiểm tra đăng nhập thành công
    ...    ELSE IF    '${status}' == 'failure'    Kiểm tra thông báo đăng nhập thất bại
    ...    ELSE IF    '${status}' == 'required'   Kiểm tra lỗi trường bắt buộc
