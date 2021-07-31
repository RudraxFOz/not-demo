public class ContactSearch {

    public Static List<Contact> searchForContacts(String namef,String names) {
        Integer a = 5;
        Integer b = a/0;
        System.debug(b);
        List<Contact> relList = [SELECT Id,Name,LastName,MailingPostalCode FROM Contact
                                WHERE LastName = :namef AND MailingPostalCode = :names];
        return relList;
    }
    
}