@isTest
public class TestRestrictContactByName {
	
     Static testMethod  void ContactByName() {
        List<Contact> listtype = new List<Contact>();
         Contact cf = new Contact(FirstName='naresh',LastName='Singh');
         Contact cs = new Contact(FirstName='Mukesh',LastName='INVALIDNAME');
          listtype.add(cf);
          listtype.add(cs);
          Test.startTest();
         try {
             insert listtype;
         } catch(Exception e) { }
         Test.stopTest();
    }
}