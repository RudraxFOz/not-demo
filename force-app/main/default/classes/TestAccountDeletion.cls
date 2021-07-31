@isTest
Private class TestAccountDeletion {
    @isTest Static void TestDeleteAccountWithOneOpportunity() {
        Account ac = new Account(Name='Test Account');
        insert ac;
        Opportunity op=new Opportunity(Name=ac.Name+'Opportunity',StageName='Prospecting',CloseDate=System.today().addMonths(1),AccountId=ac.Id);
        insert op;
        Test.startTest();
        Database.DeleteResult result = Database.delete(ac,false);
        Test.stopTest();
        //System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals('Cannot delete account with related opportunities.',result.getErrors()[0].getMessage());
    }
}