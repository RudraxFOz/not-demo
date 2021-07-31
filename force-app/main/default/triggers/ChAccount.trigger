trigger ChAccount on Account (after insert) {
    List<Contact> con = new List<Contact>();
    for(Account a:Trigger.New) {
        if(a.industry=='Banking') {
            Contact c = new Contact();
            c.LastName=a.Name;
            c.phone=a.Phone;
            c.AccountId=a.Id;
            con.add(c);
        }
    }
    insert con;
}