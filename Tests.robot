*** Settings ***
Resource    Pages/Actions.robot
Suite Setup    Set Selenium Speed    0.05
Suite Teardown    Close All Browsers

*** Test Cases ***
NegativeRegistrationFlowFromRegistrationPage
    [Tags]    NegFlow    Warnings    Regis
    [Setup]
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
    [Teardown]

NegativeRegistrationFlowFromLoginPage
    [Tags]    NegFlow    Login
    [Setup]
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
    [Teardown]

PositiveRegistrationFlowFromRegistrationPage
    [Tags]    PosFlow    Regis
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Register Page
    Actions.PositiveRegisterUser1
    [Teardown]

PositiveRegistrationFlowFromLoginPage
    [Tags]    PosFlow    Login
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.RedirectionFromLogintoRegistration
    Actions.PositiveRegisterUser2
    [Teardown]

ForgotPasswordFlow
    [Tags]    NegFlow    PosFlow    Login
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.CheckForgotPasswordWithInvaildEmail
    Actions.CheckForgotPasswordWithValidEmail
    [Teardown]

NegativeLoginFlow
    [Tags]    PosFlow    WOLogIn    Login
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromInvalidEmailFormat
    Actions.LoginFromInvalidCreds
    Actions.LoginFromInvalidPassword
    Actions.LoginFromInvalidEmail
    [Teardown]
    
PositiveLoginandLogoutFlow
    [Tags]    PosFlow    WLogIn    Login
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.Logout
    [Teardown]

VerifyAddToWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Login    Wishlist    Add
    [Setup]
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
    [Teardown]

VerifyAddToCartFunctionality
    [Tags]    PosFlow    WLogIn    Login    Cart    Add
    [Setup]
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
    [Teardown]

VerifyRemoveFromCartFunctionality
    [Tags]    PosFlow    WLogIn    Cart    Remove
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct5FromCart
    Actions.VerifyProduct5FromCartRemoved
    Actions.RemoveProduct2FromCart
    Actions.VerifyProduct2FromCartRemoved
    Actions.Logout
    [Teardown]

VerifyRemoveFromWishlistFunctionality
    [Tags]    PosFlow    WLogIn    Wishlist    Remove
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.RemoveProduct4FromWishlist
    Actions.VerifyProduct4FromWishlistRemoved
    Actions.Logout
    [Teardown]

VerifyItemsInCartAfterReLogin
    [Tags]    PosFlow    WReLogin    Cart
    [Setup]
    PageVerifications.Home Page
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
    [Teardown]

VerifyItemsInWishlistAfterReLogin
    [Tags]    PosFlow    WReLogin    Wishlist
    [Setup]
    PageVerifications.Home Page
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
    [Teardown]

SearchForProducts
    [Tags]    PosFlow    WLogIn    Search
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    Actions.Logout
    [Teardown]

VerifyAddToWishlistFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Wishlist
    [Setup]
    PageVerifications.Home Page
    Actions.AddProduct3ToWishlist
    Actions.VerifyProduct3ToWishlistAdded
    Actions.AddProduct4ToWishlist
    Actions.VerifyProduct4ToWishlistAdded
    Actions.SearchProduct5AddToWishlist
    Actions.VerifyProduct5ToWishlistAdded
    [Teardown]

VerifyAddToCartFunctionalityWOLogin
    [Tags]    WOLogIn    PosFlow    Search    Cart
    [Setup]
    PageVerifications.Home Page
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    [Teardown]

VerifyCheckoutFunctionalityWOLgin
    [Tags]    WOLogIn    PosFlow   Cart    Search
    [Setup]
    PageVerifications.Home Page
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.SearchProduct5AddToWishlist
    Actions.AddProduct5FromWishlistToCart
    Actions.CheckoutProductsWOLogin
    [Teardown]

VerifyCheckoutFunctionalityWLogin
    [Tags]    WLogIn    PosFlow   Cart    Search
    [Setup]
    PageVerifications.Home Page
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
    [Teardown]

VerifyPopupOnCheckoutWLogin
    [Tags]    WLogIn    PosFlow   Cart    Search
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.VerifyTermsOfServicePopup
    [Teardown]

VerifyPopupOnCheckoutWOLogin
    [Tags]    WOLogIn    PosFlow   Cart    Search
    [Setup]
    PageVerifications.Home Page
    Actions.AddProduct1ToCart
    Actions.VerifyProduct1ToCartAdded
    Actions.SearchProduct2AddToCart
    Actions.VerifyProduct2ToCartAdded
    Actions.VerifyTermsOfServicePopup
    [Teardown]
    
Cleanup
    [Tags]    WLogIn    Cleanup    Special
    [Setup]
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.LoginFromValidCreds
    Actions.NewClearCart
    Actions.NewClearWishlist
    Actions.Logout
    [Teardown]