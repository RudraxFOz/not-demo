public without sharing class TestApex {
   public Account dummyOpp {get; set;} 
   public List<String> fieldNames {get; set;}
       public List<WrapperAcc> fieldNames1 {get; set;}

   public TestApex(){
      //Initialize the placeholder Opportunity
      dummyOpp = new Account();

      //Now let's get the List of fields from our custom setting
      fieldNames = new List<String>();
        fieldNames1 = new List<WrapperAcc>();
      for(Account fieldName : [SELECT Id,Name,AccountNumber FROM Account  LIMIT 5]){
         fieldNames.add(fieldName.Name);
          WrapperAcc acc = new WrapperAcc();
          acc.Name = fieldName.Name ;
          acc.AccountNumber = fieldName.AccountNumber ;
          fieldNames1.add(acc);
      }
   }
     
    public class WrapperAcc {
        public String Name{get; set;}
        public String AccountNumber{get; set;}
        public Account acc {get; set;}
        public Integer attr1;
        public String attr2;
        public Decimal attr3;
           
    }
}