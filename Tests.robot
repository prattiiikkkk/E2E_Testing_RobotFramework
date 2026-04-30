*** Settings ***
Resource    Pages/Actions.robot

*** Variables ***
${Browser}    gc    #You can use either: gc, edge, or ff browsers

*** Keywords ***
Setup
    Sleep    1s
    Set Selenium Speed    0.25s
    PageVerifications.Home Page

Teardown
    Close All Browsers

*** Test Cases ***
NegativeRegistrationFlowFromRegistrationPage
    [Tags]    NegFlow    Warnings    Regis
    [Setup]    Setup
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
    [Teardown]    Teardown

NegativeRegistrationFlowFromLoginPage
    [Tags]    NegFlow    Login
    [Setup]    Setup
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
    [Teardown]    Teardown

PositiveRegistrationFlowFromRegistrationPage
    [Tags]    PosFlow    Regis
    [Setup]    Setup
    PageVerifications.Register Page
    Actions.PositiveRegisterUser
    [Teardown]    Teardown

PositiveRegistrationFlowFromLoginPage
    [Tags]    PosFlow    Login
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.RedirectionFromLogintoRegistration
    Actions.PositiveRegisterUser
    [Teardown]    Teardown

ForgotPasswordFlow
    [Tags]    NegFlow    PosFlow    Login
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.CheckForgotPasswordWithInvaildEmail
    Actions.CheckForgotPasswordWithValidEmail
    [Teardown]    Teardown

NegativeLoginFlow
    [Tags]    PosFlow    WOLogIn    Login
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromInvalidEmailFormat
    Actions.LoginFromInvalidCreds
    Actions.LoginFromInvalidPassword
    Actions.LoginFromInvalidEmail
    [Teardown]    Teardown
    
PositiveLoginandLogoutFlow
    [Tags]    PosFlow    WLogIn    Login
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.Logout
    PageVerifications.Login Page
    Actions.CheckLoginWithForgotPasswordUser
    Actions.Logout
    [Teardown]    Teardown

VerifyAddToWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Login    Wishlist    Add
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.AddProduct5ToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout
    [Teardown]    Teardown

VerifyAddToCartFunctionality
    [Tags]    PosFlow    WLogIn    Login    Cart    Add
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.AddProduct2ToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.AddProduct5FromWishlistToCart
    Actions.VerifyProduct5FromWishlistToCartMoved
    Actions.Logout
    [Teardown]    Teardown

VerifyRemoveFromCartFunctionality
    [Tags]    PosFlow    WLogIn    Cart    Remove
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct5FromCart
    Actions.VerifyProduct5FromCartRemoved
    Actions.RemoveProduct2FromCart
    Actions.VerifyProduct2FromCartRemoved
    Actions.Logout
    [Teardown]    Teardown

VerifyRemoveFromWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Wishlist    Remove
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct4FromWishlist
    Actions.VerifyProduct4FromWishlistRemoved
    Actions.Logout
    [Teardown]    Teardown

VerifyItemsInCartAfterReLogin
    [Tags]    PosFlow    WReLogin    Cart
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
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
    [Teardown]    Teardown

VerifyItemsInWishlistAfterReLogin
    [Tags]    PosFlow    WReLogin    Wishlist
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
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
    [Teardown]    Teardown

SearchForProducts
    [Tags]    PosFlow    WLogIn    Search
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout
    [Teardown]    Teardown

VerifyAddToWishlistFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Wishlist
    [Setup]    Setup
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    [Teardown]    Teardown

VerifyAddToCartFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Cart
    [Setup]    Setup
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    [Teardown]    Teardown

VerifyCheckoutFunctionalityWOLgin
    [Tags]    WOLogIn    PosFlow   Cart    Search
    [Setup]    Setup
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.AddProduct5FromWishlistToCart
    Actions.CheckoutProductsWOLogin
    [Teardown]    Teardown

VerifyCheckoutFunctionalityWLogin
    [Tags]    WLogIn    PosFlow   Cart    Search
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.AddProduct5FromWishlistToCart
    Actions.CheckoutProductsWLogin
    Actions.Logout
    [Teardown]    Teardown

VerifyPopupOnCheckoutWLogin
    [Tags]    WLogIn    PosFlow   Cart    Search
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.VerifyTermsOfServicePopup
    [Teardown]    Teardown

VerifyPopupOnCheckoutWOLogin
    [Tags]    WOLogIn    PosFlow   Cart    Search
    [Setup]    Setup
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.VerifyTermsOfServicePopup
    [Teardown]    Teardown
    
Cleanup
    [Tags]    WLogIn    Cleanup    Special
    [Setup]    Setup
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
    Actions.Logout
    [Teardown]    Teardown