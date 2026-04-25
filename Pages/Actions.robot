*** Settings ***
Resource    PageVerifications.robot

*** Test Cases ***
#*** Keywords ***
#PositiveRegisterUser
    #PageVerifications.Home Page
    #PageVerifications.Register Page
    #Click Element    css=input#gender-male
    #Input Text    css=input#FirstName    Test1
    #Input Text    css=input#LastName    User1
    #Input Text    css=input#Email    tu1+0000000000000000001@test.com
    #Input Password    css=input#Password    Test@User1
    #Input Password    css=input#ConfirmPassword    Test@User1
    #Click Button    css=input#register-button
    #Wait Until Page Contains Element    css=div.result
    #Page Should Contain Element    xpath=//a[text()="Log out"]

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
    Wait Until Page Contains Element    xpath=//span[text()="The password and confirmation password do not match."]

CheckAllWarnings
   #Set Selenium Speed    8
    PageVerifications.Home Page
    PageVerifications.Register Page
    Input Text    css=input#FirstName    Test1
    Click Element    css=input#FirstName
    Press Keys     css=input#FirstName    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Sleep    5
    Wait Until Page Contains Element    xpath=//span[@for='FirstName']