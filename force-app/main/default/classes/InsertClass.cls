public class InsertClass {
		   //  List<Favorite__c> favorite = new List<Favorite__c>();
    		//Integer Id;
			public void insertRecord1() {
                Favorite__c fav = new Favorite__c(Name__c='suresh',Email__c='sureshchoudharyp10@gmail.com',PhoneNo__c='7665323610');
               // favorite.add(new Favorite__c(Name__c='suresh',Email__c='sureshchoudharyp10@gmail.com',PhoneNo__c='7665323610'));
               // insert favorite;
               // insert fav;
                ID favid = fav.Id;
                System.debug('ID ='+favid);
            }

}