public class QuestionAnswerClass {

    @AuraEnabled
    public Static List<Language__c> fetchSubject() {
        return [ SELECT Id, Name, Instructions__r.Name, Instructions__r.IntroLineFirst__c, Instructions__r.IntroLineSecond__c, Instructions__r.IntroLineThird__c, Instructions__r.Number_of_questions__c, Instructions__r.Single_Choose_Marks__c, Instructions__r.Total_Time_For_Question__c FROM Language__c ] ;
    }

    @AuraEnabled
    public static List<Question1__c> getQuestionAnswers( String subjectName ) {
 
        List<Question1__c> lstQues = [SELECT Id,Name, RecordType.Name,  Question_Text__c, Question_Number__c, (SELECT Id, Name, Option__c, Correct_Answer__c FROM Answer1s__r )FROM Question1__c WHERE Language__r.Name =: subjectName];
        return lstQues;
    } 

    @AuraEnabled
    public static void insertData( String firstName, String lastName, String email, String phone) {
        System.debug('==firstName=='+firstName);
        System.debug('==lastName=='+lastName);
        System.debug('==email=='+email);
        System.debug('==phone=='+phone);
        //Account acc = new Account();
        Contact con = new Contact();
        con.accountId = '0016F00003Ni73tQAB'; 
        con.FirstName = firstName ;
        con.LastName = lastName ;
        con.Email = email;
        con.phone = phone ;
        insert con;
    }

}