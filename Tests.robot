*** Settings ***
Resource    Pages/Actions.robot

*** Test Cases ***
NegativeRegistrationFlowFromRegistrationPage
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
    PageVerifications.Home Page
    PageVerifications.Register Page
    Actions.PositiveRegisterUser

PositiveRegistrationFlowFromLoginPage
    PageVerifications.Home Page
    PageVerifications.Login Page
    Actions.RedirectionFromLogintoRegistration
    Actions.PositiveRegisterUser



