@isTest 
public class AccountTeamBatchApexTest  {


    // public static Account createAccount(Boolean doInsert) {
        
    // }
    static testMethod void testMethod1()  {
    
        List<Account> parentLstAccount= new List<Account>();
        List<Account> childLstAccount= new List<Account>();
        List<AccountTeamMember> accTeamMemberLst= new List<AccountTeamMember>();
        
        List<User> userLst= new List<User>();
            
            Boolean f1 = false;
        //for(Integer i=0 ;i <20;i++) {
        
            Account parentAccount = new Account();
            parentAccount.Name ='Parent Account1';
            f1 = true ;
            insert parentAccount ;

            System.AssertEquals(parentAccount.Name,'Parent Account1');
            //parentLstAccount.add(parentAccount);

            Account childAccount = new Account();
            childAccount.Name ='Test Account2';
            childAccount.Parent_Account__c = parentAccount.Id; 
            childAccount.National_Account__c = true ;
            childAccount.National_Account__c = false ;
            //childLstAccount.add(childAccount);
            f1 = true ;
            insert childAccount ;
            System.AssertEquals(childAccount.Name,'Test Account2');


            AccountTeamMember accTeamMember1 = new AccountTeamMember();
            accTeamMember1.TeamMemberRole ='Test AccountTeamMembe11r';
            //accTeamMember.AccountId = '0016F00003PeVGPQA3'; 
            accTeamMember1.UserId = '0056F00000BM1CRQA1'; 
            accTeamMember1.AccountId = parentAccount.Id; 
            //accTeamMemberLst1.add(accTeamMember);
            insert accTeamMember1;

            AccountTeamMember accTeamMember = new AccountTeamMember();
            accTeamMember.TeamMemberRole ='Test AccountTeamMember';
            //accTeamMember.AccountId = '0016F00003PeVGPQA3'; 
            accTeamMember.UserId = '0056F00000BM1CRQA1'; 
            accTeamMember.AccountId = childAccount.Id; 
            accTeamMemberLst.add(accTeamMember);
            f1 = true ;
            insert accTeamMember;
            System.AssertEquals(accTeamMember.TeamMemberRole,'Test AccountTeamMember');
            


           
        //}

        //  if(!accTeamMemberLst.isEmpty() ) {
        //     insert accTeamMemberLst;
        // }

        // if(!parentLstAccount.isEmpty() ) {
        //     insert parentLstAccount;
        // }

       

        // if(!childLstAccount.isEmpty() ) {
        //     insert childLstAccount;
        // }

        
        
       
        Test.startTest();

            AccountTeamBatchApex1 obj = new AccountTeamBatchApex1();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}