*** Settings ***
Library    RPA.Excel.Files
Resource    PageVerifications.robot

*** Variables ***
#Imported Excel Files for Userdata
${Regis_File}    UserData/RegistrationUsers.xlsx    #${reg}        #${forget}
${ValidCreds_File}    UserData/ValidUsers.xlsx    #${valid}
${InvalidCreds_File}    UserData/InvalidUsers.xlsx    #${invalid}

#Products
${Product1}    14.1-inch Laptop
${Product2}    Fiction
${Product3}    Phone Cover
${Product4}    50's Rockabilly Polka Dot Top JR Plus Size
${Product5}    3rd Album

@{Products}    ${Product1}    ${Product2}    ${Product3}    ${Product4}    ${Product5}


#*** Test Cases ***
*** Keywords ***
RedirectionFromLogintoRegistration
    Click Element    css=input.register-button
    Wait Until Page Contains Element    xpath=//h1[text()="Register"]

CheckDirectRegisterClickWarnings
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//span[@data-valmsg-for='FirstName']//span[text()='First name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='LastName']//span[text()='Last name is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']
    Page Should Contain Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckEmailRequiredWarnings
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${invalid}[5]
    Click Element    css=input#FirstName
    Press Keys     css=input#Email    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']

PositiveRegisterUser
    Open Workbook    ${Regis_File}
    ${reg}=    Read Worksheet As Table    header=True
    FOR    ${index}    ${reg}    IN ENUMERATE    @{reg}
        IF    '${reg}[Used]' == 'NO'
            Set Worksheet Value    ${index + 2}    5    YES
            Save Workbook
            Close Workbook
            Click Element    css=input#gender-male
            Input Text    css=input#FirstName    ${reg}[Regis_FirstName]
            Input Text    css=input#LastName    ${reg}[Regis_LastName]
            Input Text    css=input#Email    ${reg}[Regis_Email]
            Input Password    css=input#Password    ${reg}[Regis_Password]
            Input Password    css=input#ConfirmPassword    ${reg}[Regis_Password]
            Click Button    css=input#register-button
            Wait Until Page Contains Element    css=div.result    60s
            Page Should Contain Element    xpath=//a[text()="${reg}[Regis_Email]"]
            RETURN
        END
    END
    Close Workbook
    Fail    No unused users available in Excel

NegativeRegisterUser
    Open Workbook    ${ValidCreds_File}
    ${valid}=    Read Worksheet As Table    header=True
    ${valid}=    Set Variable    ${valid}[0]
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${invalid}[0]
    Input Text    css=input#LastName    ${invalid}[1]
    Input Text    css=input#Email    ${invalid}[2]
    Input Password    css=input#Password    ${valid}[3]
    Input Password    css=input#ConfirmPassword    ${invalid}[3]
    Click Button    css=input#register-button
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()="The password and confirmation password do not match."]

CheckWrongEmailWarnings
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${invalid}[6]
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Wrong email']

CheckPasswordLengthWarning
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Password    css=input#Password    ${invalid}[5]
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='The password should have at least 6 characters.']

CheckPasswordRequiredWarning
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Password    css=input#Password    ${invalid}[5]
    Click Element    css=input#FirstName
    Press Keys     css=input#Password    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']

CheckConfirmPasswordMismatchWarning
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Password    css=input#ConfirmPassword    ${invalid}[5]
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='The password and confirmation password do not match.']

CheckConfirmPasswordRequiredWarning
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Password    css=input#ConfirmPassword    ${invalid}[5]
    Click Element    css=input#FirstName
    Press Keys     css=input#ConfirmPassword    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckAlreadyRegisteredUserWarning
    Open Workbook    ${ValidCreds_File}
    ${valid}=    Read Worksheet As Table    header=True
    ${valid}=    Set Variable    ${valid}[0]
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${valid}[0]
    Input Text    css=input#LastName    ${valid}[1]
    Input Text    css=input#Email    ${valid}[2]
    Input Password    css=input#Password    ${valid}[3]
    Input Password    css=input#ConfirmPassword    ${valid}[3]
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The specified email already exists"]

LoginFromInvalidEmailFormat
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${invalid}[6]
    Click Element    css=input#Password
    Wait Until Page Contains Element    xpath=//span[@class="field-validation-error"]//span[text()="Please enter a valid email address."]

LoginFromInvalidCreds
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${invalid}[2]
    Input Password    css=input#Password    ${invalid}[3]
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]
    
LoginFromInvalidPassword
    Open Workbook    ${ValidCreds_File}
    ${valid}=    Read Worksheet As Table    header=True
    ${valid}=    Set Variable    ${valid}[0]
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${valid}[2]
    Input Password    css=input#Password    ${invalid}[3]
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The credentials provided are incorrect"]

LoginFromInvalidEmail
    Open Workbook    ${ValidCreds_File}
    ${valid}=    Read Worksheet As Table    header=True
    ${valid}=    Set Variable    ${valid}[0]
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Input Text    css=input#Email    ${invalid}[2]
    Input Password    css=input#Password    ${valid}[3]
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]

LoginFromValidCreds
    Open Workbook    ${ValidCreds_File}
    ${valid}=    Read Worksheet As Table    header=True
    ${valid}=    Set Variable    ${valid}[0]
    Input Text    css=input#Email    ${valid}[2]
    Input Password    css=input#Password    ${valid}[3]
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//a[text()="${valid}[2]"]

Logout
    Click Element    xpath=//a[text()="Log out"]
    Wait Until Page Contains Element    xpath=//a[text()="Log in"]

CheckForgotPasswordWithInvaildEmail
    Open Workbook    ${InvalidCreds_File}
    ${invalid}=    Read Worksheet As Table    header=True
    ${invalid}=    Set Variable    ${invalid}[0]
    Click Element    xpath=//a[text()="Forgot password?"]
    Wait Until Page Contains Element    xpath=//div[@class="page-title"]//h1[text()="Password recovery"]
    Input Text    css=input#Email    ${invalid}[2]
    Click Button    xpath=//input[@value="Recover"]
    Wait Until Page Contains Element    xpath=//div[@class="result"]

CheckForgotPasswordWithValidEmail
    Open Workbook    ${Regis_File}
    ${forget}=    Read Worksheet As Table    header=True
    FOR    ${index}    ${forget}    IN ENUMERATE    @{forget}
        IF    '${forget}[Used]' == 'Yes'
            Set Worksheet Value    ${index + 2}    5    Forget_Password
            Save Workbook
            Close Workbook
            Input Text    css=input#Email    ${forget}[Regis_Email]
            Click Button    xpath=//input[@value="Recover"]
            Wait Until Page Contains Element    xpath=//div[@class="result"]
            RETURN
        END
    END
    Close Workbook
    Fail    No users available in Excel for Forget Password

CheckLoginWithForgotPasswordUser
    Open Workbook    ${Regis_File}
    ${forget}=    Read Worksheet As Table    header=True
    ${forget}=    Set Variable    ${forget}[0]
    Input Text    css=input#Email    ${forget}[2]
    Input Password    css=input#Password    ${forget}[3]
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//a[text()="${forget}[2]"]

AddProduct1ToCart
    Click Element    xpath=//h2/a[text()="${Product1}"]
    Wait Until Page Contains Element    css=input#add-to-cart-button-31
    Click Button    css=input#add-to-cart-button-31

VerifyProduct1ToCartAdded
    PageVerifications.ShoppingCart Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product1}"]

AddProduct2ToCart
    Click Element    xpath=//ul[@class="top-menu"]/li[1]
    Wait Until Page Contains Element    xpath=//h1[text()="Books"]
    Click Element    xpath=//h2/a[text()="${Product2}"]
    Wait Until Page Contains Element    css=input#add-to-cart-button-45
    Click Button    css=input#add-to-cart-button-45

VerifyProduct2ToCartAdded
    PageVerifications.ShoppingCart Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product2}"]

AddProduct3ToWishlist
    Click Element    xpath=//ul[@class="top-menu"]/li[3]
    Wait Until Page Contains Element    xpath=//h1[text()="Electronics"]
    Click Element    xpath=//h2[@class="title"]/a[@title="Show products in category Cell phones"]
    Wait Until Page Contains Element    xpath=//h1[text()="Cell phones"]
    Click Element    xpath=//h2/a[text()="${Product3}"]
    Wait Until Page Contains Element    css=input#add-to-wishlist-button-80
    Click Button    css=input#add-to-wishlist-button-80

VerifyProduct3ToWishlistAdded
    PageVerifications.Wishlist Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product3}"]

AddProduct4ToWishlist
    Click Element    xpath=//ul[@class="top-menu"]/li[4]
    Wait Until Page Contains Element    xpath=//h1[text()="Apparel & Shoes"]
    Click Element    xpath=//h2/a[text()="${Product4}"]
    Wait Until Page Contains Element    css=input#add-to-wishlist-button-5
    Click Button    css=input#add-to-wishlist-button-5

VerifyProduct4ToWishlistAdded
    PageVerifications.Wishlist Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product4}"]

AddProduct5ToWishlist
    Click Element    xpath=//ul[@class="top-menu"]/li[5]
    Wait Until Page Contains Element    xpath=//h1[text()="Digital downloads"]
    Click Element    xpath=//h2/a[text()="${Product5}"]
    Wait Until Page Contains Element    css=input#add-to-wishlist-button-53
    Click Button    css=input#add-to-wishlist-button-53

VerifyProduct5ToWishlistAdded
    PageVerifications.Wishlist Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product5}"]

AddProduct5FromWishlistToCart
    PageVerifications.Wishlist Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product5}"]
    Select Checkbox    xpath=//a[text()="${Product5}"]/ancestor::tr//input[@name="addtocart"]
    Click Element    xpath=//input[@name="addtocartbutton"]
    PageVerifications.ShoppingCart Page
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product5}"]

VerifyProduct5FromWishlistToCartMoved
    PageVerifications.Wishlist Page
    Page Should Not Contain Element    xpath=//td[@class="product"]/a[text()="${Product5}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product4}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product3}"]

RemoveProduct4FromWishlist
    PageVerifications.Wishlist Page
    Wait Until Page Contains Element    xpath=//td[@class="product"]/a[text()="${Product4}"]
    Select Checkbox    xpath=//a[text()="${Product4}"]/ancestor::tr//input[@name="removefromcart"]
    Click Element    xpath=//input[@name="updatecart"]

VerifyProduct4FromWishlistRemoved
    Page Should Not Contain Element    xpath=//td[@class="product"]/a[text()="${Product4}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product3}"]

RemoveProduct5FromCart
    PageVerifications.ShoppingCart Page
    Select Checkbox    xpath=//a[text()="${Product5}"]/ancestor::tr//input[@name="removefromcart"]
    Click Element    xpath=//input[@name="updatecart"]

VerifyProduct5FromCartRemoved
    Page Should Not Contain Element    xpath=//td[@class="product"]/a[text()="${Product5}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product2}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product1}"]

RemoveProduct2FromCart
    PageVerifications.ShoppingCart Page
    Select Checkbox    xpath=//a[text()="${Product2}"]/ancestor::tr//input[@name="removefromcart"]
    Click Element    xpath=//input[@name="updatecart"]

VerifyProduct2FromCartRemoved
    Page Should Not Contain Element    xpath=//td[@class="product"]/a[text()="${Product2}"]
    Page Should Contain Element    xpath=//td[@class="product"]/a[text()="${Product1}"]

VerifyTermsOfServicePopup
    PageVerifications.ShoppingCart Page
    Click Element    css=button#checkout
    Page Should Contain Element    css=span#ui-id-2

CheckoutProductsWLogin
    PageVerifications.ShoppingCart Page
    Select Checkbox    css=input#termsofservice
    Click Element    css=button#checkout
    Page Should Contain Element    xpath=//h1[text()="Checkout"]

CheckoutProductsWOLogin
    PageVerifications.ShoppingCart Page
    Select Checkbox    css=input#termsofservice
    Click Element    css=button#checkout
    Page Should Contain Element    xpath=//h1[text()="Welcome, Please Sign In!"]

ClearCart
    PageVerifications.ShoppingCart Page
    FOR    ${Product}    IN     @{Products}
        Run Keyword And Return Status
        ...    Select Checkbox       xpath=//a[text()="${Product}"]/ancestor::tr//input[@name="removefromcart"]
    END
    Click Element    xpath=//input[@name="updatecart"]
    PageVerifications.Empty ShoppingCart Page
    Click Element    //div[@class="header-logo"]
        
ClearWishlist
    PageVerifications.Wishlist Page
    FOR    ${Product}    IN     @{Products}
        Run Keyword And Return Status
        ...    Select Checkbox       xpath=//a[text()="${Product}"]/ancestor::tr//input[@name="removefromcart"]
    END
    Click Element    xpath=//input[@name="updatecart"]
    PageVerifications.Empty Wishlist Page
    Click Element    xpath=//div[@class="header-logo"]

SearchProduct2AddToCart
    Input Text    css=input#small-searchterms    ${Product2}
    Click Button    xpath=//input[@value="Search"]
    Wait Until Page Contains Element    xpath=//h2/a[text()="${Product2}"]
    Click Element    xpath=//h2/a[text()="${Product2}"]
    Wait Until Page Contains Element    css=input#add-to-cart-button-45
    Click Button    css=input#add-to-cart-button-45

SearchProduct5AddToWishlist
    Input Text    css=input#small-searchterms    ${Product5}
    Click Button    xpath=//input[@value="Search"]
    Wait Until Page Contains Element    xpath=//h2/a[text()="${Product5}"]
    Click Element    xpath=//h2/a[text()="${Product5}"]
    Wait Until Page Contains Element    css=input#add-to-wishlist-button-53
    Click Button    css=input#add-to-wishlist-button-53

NewClearCart
    PageVerifications.ShoppingCart Page
    ${cart_has_items}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    xpath=//input[@name="removefromcart"]
    IF    ${cart_has_items}
        ${items}=    Get WebElements    xpath=//input[@name="removefromcart"]

        FOR    ${item}    IN    @{items}
            Select Checkbox    ${item}
        END
        Click Element    xpath=//input[@name="updatecart"]
        PageVerifications.Empty ShoppingCart Page
    ELSE
        Log    Cart is already empty
    END
    Click Element    xpath=//div[@class="header-logo"]

NewClearWishlist
     PageVerifications.Wishlist Page
    ${wishlist_has_items}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    xpath=//input[@name="removefromcart"]
    IF    ${wishlist_has_items}
        ${items}=    Get WebElements    xpath=//input[@name="removefromcart"]

        FOR    ${item}    IN    @{items}
            Select Checkbox    ${item}
        END
        Click Element    xpath=//input[@name="updatecart"]
        PageVerifications.Empty Wishlist Page
    ELSE
        Log    Wishlist is already empty
    END
    Click Element    xpath=//div[@class="header-logo"]