public class HelperForAccountandContact {
    public static void countTheTotal() {
               list<Account> listacc = [SELECT id,Name,(SELECT id FROM Contacts) FROM Account ];
        	   for(Account acccount : listacc) {
            		acccount.TotalContactNumber__c = acccount.Contacts.size();
               }
        	   update listacc;
    }
    public static void methodOnContact(list<Contact> listcon) {
     
        
     // listcon = [SELECT id,(SELECT id FROM )]
        for(Contact con: listcon) {
           //listcon.add(sequence_number__c = '10');
           con.sequence_number__c = 10;
            
        }
        update listcon;
       
    }

}