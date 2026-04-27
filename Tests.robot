*** Settings ***
Resource    Pages/Actions.robot

*** Test Cases ***
NegativeRegistrationFlowFromRegistrationPage
    [Tags]    NegFlow    Warnings    Regis
    PageVerifications.Home Page
    PageVerifications.Register Page
    Actions.CheckDirectRegisterClickWarnings
    Actions.CheckEmailRequiredWarnings
    Actions.NegativeRegisterUser
    Actions.CheckWrongEmailWarnings
    Actions.CheckPasswordLengthWarning
    Actions.CheckPasswordRequiredWarning
    Actions.CheckConfirmPasswordMismatchWarning
    Actions.CheckConfirmPasswordRequiredWarning
    Actions.CheckAlreadyRegisteredUserWarning

NegativeRegistrationFlowFromLoginPage
    [Tags]    NegFlow    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.RedirectionFromLogintoRegistration
    Actions.CheckDirectRegisterClickWarnings
    Actions.CheckEmailRequiredWarnings
    Actions.NegativeRegisterUser
    Actions.CheckWrongEmailWarnings
    Actions.CheckPasswordLengthWarning
    Actions.CheckPasswordRequiredWarning
    Actions.CheckConfirmPasswordMismatchWarning
    Actions.CheckConfirmPasswordRequiredWarning
    Actions.CheckAlreadyRegisteredUserWarning

PositiveRegistrationFlowFromRegistrationPage
    [Tags]    PosFlow    Regis
    PageVerifications.Home Page
    PageVerifications.Register Page
    Actions.PositiveRegisterUser

PositiveRegistrationFlowFromLoginPage
    [Tags]    PosFlow    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.RedirectionFromLogintoRegistration
    Actions.PositiveRegisterUser

ForgotPasswordFlow
    [Tags]    NegFlow    PosFlow    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.CheckForgotPasswordWithInvaildEmail
    Actions.CheckForgotPasswordWithValidEmail

NegativeLoginFlow
    [Tags]    PosFlow    WOLogIn    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromInvalidEmailFormat
    Actions.LoginFromInvalidCreds
    Actions.LoginFromInvalidPassword
    Actions.LoginFromInvalidEmail
    
PositiveLoginandLogoutFlow
    [Tags]    PosFlow    WLogIn    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.Logout

VerifyAddToWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Login    Wishlist    Add
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.AddProduct5ToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout

VerifyAddToCartFunctionality
    [Tags]    PosFlow    WLogIn    Login    Cart    Add
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.AddProduct2ToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.AddProduct5FromWishlistToCart
    Actions.VerifyProduct5FromWishlistToCartMoved
    Actions.Logout

VerifyRemoveFromCartFunctionality
    [Tags]    PosFlow    WLogIn    Cart    Remove
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct5FromCart
    Actions.VerifyProduct5FromCartRemoved
    Actions.RemoveProduct2FromCart
    Actions.VerifyProduct2FromCartRemoved
    Actions.Logout

VerifyRemoveFromWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Wishlist    Remove
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct4FromWishlist
    Actions.VerifyProduct4FromWishlistRemoved
    Actions.Logout

VerifyItemsInCartAfterReLogin
    [Tags]    PosFlow    WReLogin    Cart
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.ClearCart
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.AddProduct2ToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.Logout
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.VerifyProduct1ToCartAdded
    Actions.VerifyProduct2ToCartAdded
    Actions.Logout

VerifyItemsInWishlistAfterReLogin
    [Tags]    PosFlow    WReLogin    Wishlist
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.ClearWishlist
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.AddProduct5ToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.VerifyProduct3ToWishlistAdded
    Actions.VerifyProduct4ToWishlistAdded
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout

SearchForProducts
    [Tags]    PosFlow    WLogIn    Search
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.ClearCart
    Actions.ClearWishlist
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout

VerifyAddToWishlistFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Wishlist
    PageVerifications.Home Page
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded

VerifyAddToCartFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Cart
    Set Selenium Speed    0.5
    PageVerifications.Home Page
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded

VerifyCheckoutFunctionality
    [Tags]    WLogIn    PosFlow   Cart    Search
    PageVerifications.Home Page
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.AddProduct5FromWishlistToCart
    Actions.VerifyProduct5FromWishlistToCartMoved
    Actions.CheckoutProducts
    Page Should Contain Element    xpath=//h1[text()="Welcome, Please Sign In!"]