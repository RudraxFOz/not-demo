public with sharing class AuthorizeResponseWrapper {
    @AuraEnabled
    public String transactionResponse {get;set;}
    @AuraEnabled
    public String refId {get;set;}
    @AuraEnabled
    public String messages {get;set;}
}