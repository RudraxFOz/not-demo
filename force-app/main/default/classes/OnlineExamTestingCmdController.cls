public with sharing class OnlineExamTestingCmdController {
    List<Language__c> languageLst = [ SELECT Id, Name FROM Language__c];
    
}