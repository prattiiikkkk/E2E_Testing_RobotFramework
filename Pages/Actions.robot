*** Settings ***
Resource    PageVerifications.robot

*** Variables ***
${NewEmail}    tu1+0000000001@test.com
${NewEmail2}    tu1+0000000001@test.com
${ValidEmail}    tu1@test.com
${SmallInvalidEmail}    t@o.m
${InValidEmail}    tu1+00000000000000001@test.com
${WrongEmail}    tpoi
${ForgetEmail}    Forget@Pswd.com
${ForgetPassword}    FgtEml.123
${ValidPassword}    Test@User1
${SmallInvalidPassword}    123
${InvalidPassword}    Test@User0
${SmallPassword}    Tes
${FirstName}    Test1
${LastName}    User1

#Products
@{Products}    ${Product1}    ${Product2}    ${Product3}    ${Product4}    ${Product5}
${Product1}    14.1-inch Laptop
${Product2}    Fiction
${Product3}    Phone Cover
${Product4}    50's Rockabilly Polka Dot Top JR Plus Size
${Product5}    3rd Album

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
    Input Text    css=input#Email    ${SmallInvalidEmail}
    Click Element    css=input#FirstName
    Press Keys     css=input#Email    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Email is required.']

PositiveRegisterUser1
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${NewEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${ValidPassword}
    Click Button    css=input#register-button
    Wait Until Page Contains Element    css=div.result
    Page Should Contain Element    xpath=//a[text()="${NewEmail}"]

PositiveRegisterUser2
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${NewEmail2}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${ValidPassword}
    Click Button    css=input#register-button
    Wait Until Page Contains Element    css=div.result
    Page Should Contain Element    xpath=//a[text()="${NewEmail2}"]

NegativeRegisterUser
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${InValidPassword}
    Click Button    css=input#register-button
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()="The password and confirmation password do not match."]

CheckWrongEmailWarnings
    Input Text    css=input#Email    ${WrongEmail}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Email']//span[text()='Wrong email']

CheckPasswordLengthWarning
    Input Password    css=input#Password    ${SmallPassword}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='The password should have at least 6 characters.']

CheckPasswordRequiredWarning
    Input Password    css=input#Password    ${SmallPassword}
    Click Element    css=input#FirstName
    Press Keys     css=input#Password    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='Password']//span[text()='Password is required.']

CheckConfirmPasswordMismatchWarning
    Input Password    css=input#ConfirmPassword    ${SmallPassword}
    Click Element    css=input#FirstName
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='The password and confirmation password do not match.']

CheckConfirmPasswordRequiredWarning
    Input Password    css=input#ConfirmPassword    ${SmallPassword}
    Click Element    css=input#FirstName
    Press Keys     css=input#ConfirmPassword    BACKSPACE    BACKSPACE    BACKSPACE
    Wait Until Page Contains Element    xpath=//span[@data-valmsg-for='ConfirmPassword']//span[text()='Password is required.']

CheckAlreadyRegisteredUserWarning
    Click Element    css=input#gender-male
    Input Text    css=input#FirstName    ${FirstName}
    Input Text    css=input#LastName    ${LastName}
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Input Password    css=input#ConfirmPassword    ${ValidPassword}
    Click Button    css=input#register-button
    Page Should Contain Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The specified email already exists"]

LoginFromInvalidEmailFormat
    Input Text    css=input#Email    ${WrongEmail}
    Click Element    css=input#Password
    Wait Until Page Contains Element    xpath=//span[@class="field-validation-error"]//span[text()="Please enter a valid email address."]

LoginFromInvalidCreds
    Input Text    css=input#Email    ${InvalidEmail}
    Input Password    css=input#Password    ${InvalidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]
    
LoginFromInvalidPassword
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${InvalidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="The credentials provided are incorrect"]

LoginFromInvalidEmail
    Input Text    css=input#Email    ${InvalidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//span[text()="Login was unsuccessful. Please correct the errors and try again."]
    Wait Until Page Contains Element    xpath=//div[@class="validation-summary-errors"]//li[text()="No customer account found"]

LoginFromValidCreds
    Input Text    css=input#Email    ${ValidEmail}
    Input Password    css=input#Password    ${ValidPassword}
    Click Button    xpath=//input[@value="Log in"]
    Wait Until Page Contains Element    xpath=//a[text()="${ValidEmail}"]

Logout
    Click Element    xpath=//a[text()="Log out"]
    Wait Until Page Contains Element    xpath=//a[text()="Log in"]

CheckForgotPasswordWithInvaildEmail
    Click Element    xpath=//a[text()="Forgot password?"]
    Wait Until Page Contains Element    xpath=//div[@class="page-title"]//h1[text()="Password recovery"]
    Input Text    css=input#Email    ${InvalidEmail}
    Click Button    xpath=//input[@value="Recover"]
    Wait Until Page Contains Element    xpath=//div[@class="result"]

CheckForgotPasswordWithValidEmail
    Input Text    css=input#Email    ${ForgetEmail}
    Click Button    xpath=//input[@value="Recover"]
    Wait Until Page Contains Element    xpath=//div[@class="result"]

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