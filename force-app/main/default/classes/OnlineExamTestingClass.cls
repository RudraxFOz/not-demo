public with sharing class OnlineExamTestingClass {

    @AuraEnabled
    public Static List<Language__c> fetchSubject() {
        return [ SELECT Id, Name FROM Language__c ] ;
    }

    @AuraEnabled
    public Static List<Answer__c> showQuestion(  String subjectName ) {

        return [SELECT Id, Name, A__c, B__c, C__c, D__c, E__c, RecordType.Name, Multi_Correct_Answer__c,Correct_Answer__c, OptionForAnswer__r.A__c,OptionForAnswer__r.B__c,OptionForAnswer__r.C__c,OptionForAnswer__r.D__c, Question__r.AskQuestion__c , Question__r.Question_Number__c , Question__r.Language__r.Name FROM Answer__c WHERE Question__r.Language__r.Name =: subjectName];

    }



}