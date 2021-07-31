@isTest 
public with sharing class AuthorizePaymentTest {
     static testMethod void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AuthorizePaymentMockTest());  
        AuthorizePaymentGatewayController.transactionResponse strResp = new AuthorizePaymentGatewayController.transactionResponse();
        strResp = AuthorizePaymentGatewayController.authorizeCard('43242344343', '567', '12', '2012', '8zQYF7f7r', '9nEp79YN59sxa2qW', '5');
    }
}