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
    [Tags]    WOLogIn    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromInvalidEmailFormat
    Actions.LoginFromInvalidCreds
    Actions.LoginFromInvalidPassword
    Actions.LoginFromInvalidEmail
    
PositiveLoginandLogoutFlow
    [Tags]    WLogIn    Login
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.Logout

VerifyAddToWishlistFunctionality
    [Tags]    WLogIn    Login    Wishlist    Add
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
    [Tags]    WLogIn    Login    Cart    Add
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
    [Tags]    WLogIn    Cart    Remove
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct5FromCart
    Actions.VerifyProduct5FromCartRemoved
    Actions.RemoveProduct2FromCart
    Actions.VerifyProduct2FromCartRemoved
    Actions.Logout

VerifyRemoveFromWishlistFunctionality
    [Tags]    WLogIn    Wishlist    Remove
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct4FromWishlist
    Actions.VerifyProduct4FromWishlistRemoved
    Actions.Logout

VerifyItemsInCartAfterReLogin
    [Tags]    WLogIn    Wishlist
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
