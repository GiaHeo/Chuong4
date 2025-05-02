*** Settings ***
Documentation     Kiểm thử trang đăng nhập OrangeHRM sử dụng mô hình Page Object
Resource          page_objects/login_page.robot
Suite Setup       Mở trang đăng nhập    ${URL}    ${BROWSER}
Suite Teardown    Close All Browsers

*** Variables ***
${URL}                https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}            chrome
${VALID_USERNAME}     Admin
${VALID_PASSWORD}     admin123
${INVALID_USERNAME}   WrongUser
${INVALID_PASSWORD}   WrongPassword

*** Test Cases ***
Đăng nhập thành công
    [Documentation]    Kiểm tra đăng nhập thành công với thông tin đúng
    Nhập tên đăng nhập    ${VALID_USERNAME}
    Nhập mật khẩu        ${VALID_PASSWORD}
    Nhấn nút đăng nhập
    Kiểm tra đăng nhập thành công

Đăng nhập thất bại với mật khẩu sai
    [Documentation]    Kiểm tra đăng nhập thất bại với mật khẩu sai
    [Setup]    Mở trang đăng nhập    ${URL}    ${BROWSER}
    Nhập tên đăng nhập    ${VALID_USERNAME}
    Nhập mật khẩu        ${INVALID_PASSWORD}
    Nhấn nút đăng nhập
    Kiểm tra thông báo đăng nhập thất bại
    [Teardown]    Close Browser

Đăng nhập thất bại với tên đăng nhập sai
    [Documentation]    Kiểm tra đăng nhập thất bại với tên đăng nhập sai
    [Setup]    Mở trang đăng nhập    ${URL}    ${BROWSER}
    Nhập tên đăng nhập    ${INVALID_USERNAME}
    Nhập mật khẩu        ${VALID_PASSWORD}
    Nhấn nút đăng nhập
    Kiểm tra thông báo đăng nhập thất bại
    [Teardown]    Close Browser

Đăng nhập với trường trống
    [Documentation]    Kiểm tra đăng nhập khi không nhập thông tin
    [Setup]    Mở trang đăng nhập    ${URL}    ${BROWSER}
    Nhập tên đăng nhập    ${EMPTY}
    Nhập mật khẩu        ${EMPTY}
    Nhấn nút đăng nhập
    Kiểm tra lỗi trường bắt buộc
    [Teardown]    Close Browser

Đăng nhập với tên đăng nhập trống
    [Documentation]    Kiểm tra đăng nhập khi không nhập tên đăng nhập
    [Setup]    Mở trang đăng nhập    ${URL}    ${BROWSER}
    Nhập tên đăng nhập    ${EMPTY}
    Nhập mật khẩu        ${VALID_PASSWORD}
    Nhấn nút đăng nhập
    Kiểm tra lỗi tên đăng nhập bắt buộc
    [Teardown]    Close Browser

Đăng nhập với mật khẩu trống
    [Documentation]    Kiểm tra đăng nhập khi không nhập mật khẩu
    [Setup]    Mở trang đăng nhập    ${URL}    ${BROWSER}
    Nhập tên đăng nhập    ${VALID_USERNAME}
    Nhập mật khẩu        ${EMPTY}
    Nhấn nút đăng nhập
    Kiểm tra lỗi mật khẩu bắt buộc
    [Teardown]    Close Browser
