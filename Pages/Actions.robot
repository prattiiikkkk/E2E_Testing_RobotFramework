*** Settings ***
Resource    PageVerifications.robot

*** Test Cases ***
#*** Keywords ***
PositiveRegisterUser
    PageVerifications.Home Page
    PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    Test1
    Input Text    css=input#LastName    User1
    Input Text    css=input#Email    tu1+0000000000000000001@test.com
    Input Password    css=input#Password    Test@User1
    Input Password    css=input#ConfirmPassword    Test@User1
    Click Button    css=input#register-button
    Wait Until Page Contains Element    css=div.result
    Page Should Contain Element    xpath=//a[text()="Log out"]

NegativeRegisterUser
    PageVerifications.Home Page
    PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    Test1
    Input Text    css=input#LastName    User1
    Input Text    css=input#Email    tu1+0000000000000000001@test.com
    Input Password    css=input#Password    Test@User1
    Input Password    css=input#ConfirmPassword    User@Test1
    Click Button    css=input#register-button
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()="The password and confirmation password do not match."]

CheckEmailRequiredWarnings
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Text    css=input#Email    t@o.m
    Click Element    css=input#FirstName
    Press Keys     css=input#Email    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']

CheckWrongEmailWarnings
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Text    css=input#Email    tpoi
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Wrong email']

CheckPasswordLengthWarning
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Password    css=input#Password    Tes
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='The password should have at least 6 characters.']

CheckPasswordRequiredWarning
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Password    css=input#Password    Tes
    Click Element    css=input#FirstName
    Press Keys     css=input#Password    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']

CheckConfirmPasswordMismatchWarning
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Password    css=input#ConfirmPassword    Tes
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='The password and confirmation password do not match.']

CheckConfirmPasswordRequiredWarning
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Password    css=input#ConfirmPassword    Tes
    Click Element    css=input#FirstName
    Press Keys     css=input#ConfirmPassword    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckDirectRegisterClickWarnings
    PageVerifications.Home Page
    PageVerifications.Register Page
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//span[@data-valmsg-for='FirstName']//span[text()='First name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='LastName']//span[text()='Last name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckAlreadyRegisteredUserWarning
    PageVerifications.Home Page
    PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    Test1
    Input Text    css=input#LastName    User1
    Input Text    css=input#Email    tu1@test.com
    Input Password    css=input#Password    Test@User1
    Input Password    css=input#ConfirmPassword    Test@User1
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The specified email already exists"]