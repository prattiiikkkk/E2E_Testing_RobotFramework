*** Settings ***
Library    SeleniumLibrary


*** Test Cases ***
Home Page
    Open Browser    https://demowebshop.tricentis.com/    gc
    Wait Until Page Contains Element    xpath=//h2[@class='topic-html-content-header']
    Sleep    2

Login Page
    Click Element    xpath=//a[text()="Log in"]
    Wait Until Page Contains Element    xpath=//h1[text()="Welcome, Please Sign In!"]
    Sleep    2

Register Page
    Click Element    xpath=//a[text()="Register"]
    Wait Until Page Contains Element    xpath=//h1[text()="Register"]
    Sleep    2

ShoppingCart Page
    Click Element    xpath=//a[text()="Shopping cart"]
    Wait Until Page Contains Element    xpath=//h1[text()="Shopping cart"]
    Sleep    2

Wishlist Page
    Click Element    xpath=//a[text()="Wishlist"]
    Wait Until Page Contains Element    xpath=//div[@class="page-title"]
    Sleep    2

Empty ShoppingCart Page
    Click Element    xpath=//a[text()="Shopping cart"]
    Page Should Not Contain Element    xpath=//form[@action="/cart"]
    Sleep    2

Empty Wishlist Page
    Click Element    xpath=//a[text()="Wishlist"]
    Page Should Not Contain Element    xpath=//form[@action="/wishlist"]
    Sleep    2

Checking Temp Banner
    Mouse Over    xpath=//a[text()="Shopping cart"]