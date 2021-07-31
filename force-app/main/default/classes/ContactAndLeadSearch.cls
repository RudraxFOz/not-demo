public class ContactAndLeadSearch {
    public Static List<List<SObject>> searchContactsAndLeads(String searchQ) {
         List<List<SObject>> SearchQuery = [FIND :searchQ IN ALL FIELDS RETURNING Lead(Name,FirstName,LastName), Contact(FirstName,LastName)];
       // List<List<SObject>> searchCon = search.query(searchQuery);
        return SearchQuery;
    }
}