*** Settings ***
Resource    PageVerifications.robot

*** Variables ***
${ValidEmail}    tu1+0000000000000000001@test.com
${SmallInvalidEmail}    t@o.m
${InValidEmail}    tu1+00000000000000001@test.com
${WrongEmail}    tpoi
${ValidPassword}    Test@User1
${SmallInvalidPassword}    
${InvalidPassword}    Test@User0
${SmallPassword}    Tes
${FirstName}    Test1
${LastName}    User1


*** Test Cases ***
#*** Keywords ***
RedirectionFromLogintoRegistration
    PageVerifications.Home Page
    PageVerifications.Login Page
    Click Element    css=input.register-button
    Wait Until Page Contains Element    xpath=//h1[text()="Register"]

CheckDirectRegisterClickWarnings
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//span[@data-valmsg-for='FirstName']//span[text()='First name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='LastName']//span[text()='Last name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckEmailRequiredWarnings
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Text    css=input#Email    ${SmallInvalidEmail}
    Click Element    css=input#FirstName
    Press Keys     css=input#Email    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']

PositiveRegisterUser
    PageVerifications.Home Page
    PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${ValidPassword}
    Click Button    css=input#register-button
    Wait Until Page Contains Element    css=div.result
    Page Should Contain Element    xpath=//a[text()="${ValidEmail}"]

NegativeRegisterUser
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${InValidPassword}
    Click Button    css=input#register-button
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()="The password and confirmation password do not match."]

CheckWrongEmailWarnings
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Text    css=input#Email    ${WrongEmail}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Wrong email']

CheckPasswordLengthWarning
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Password    css=input#Password    ${SmallPassword}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='The password should have at least 6 characters.']

CheckPasswordRequiredWarning
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Password    css=input#Password    ${SmallPassword}
    Click Element    css=input#FirstName
    Press Keys     css=input#Password    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']

CheckConfirmPasswordMismatchWarning
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Password    css=input#ConfirmPassword    ${SmallPassword}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='The password and confirmation password do not match.']

CheckConfirmPasswordRequiredWarning
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Input Password    css=input#ConfirmPassword    ${SmallPassword}
    Click Element    css=input#FirstName
    Press Keys     css=input#ConfirmPassword    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckAlreadyRegisteredUserWarning
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${ValidPassword}
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The specified email already exists"]

LoginFromInvalidEmailFormat
    #PageVerifications.Home Page
    PageVerifications.Login Page
    Input Text    css=input#Email    ${WrongEmail}
    Click Element    css=input#Password
    Wait Until Page Contains Element    xpath=//span[@class="field-validation-error"]//span[text()="Please enter a valid email address."]

LoginFromInvalidCreds
    #PageVerifications.Home Page
    #PageVerifications.Login Page
    Input Text    css=input#Email    ${InvalidEmail}
    Input Password    css=input#Password    ${InvalidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]
    
LoginFromInvalidPassword
    #PageVerifications.Home Page
    #PageVerifications.Login Page
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${InvalidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The credentials provided are incorrect"]

LoginFromInvalidEmail
    #PageVerifications.Home Page
    #PageVerifications.Login Page
    Input Text    css=input#Email    ${InvalidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]

LoginFromValidCreds
    #PageVerifications.Home Page
    #PageVerifications.Login Page
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//a[text()="${ValidEmail}"]

Logout
    #Actions.LoginFromValidCreds
    Click Element    xpath=//a[text()="Log out"]
    Wait Until Page Contains Element    xpath=//a[text()="Log in"]


