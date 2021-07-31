public with sharing class CustomAccountLookupController {
  
  public Account account {get;set;} // new account to create
  public List<Account> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  public list<conAccount> contactList{get;set;}
    public boolean allbool{get;set;}
      public string lookUp{get;set;}
      public boolean bool{get;set;}
    
    public set<id> contactids{get;set;}
  
  public CustomAccountLookupController() {
    account = new Account();
      allbool = false;
      bool = false;
      contactList = new list<conAccount>();
      contactids = new Set<Id>();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    runSearch();  
  }
   
  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }
  
  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 
  
  // run the search and return the records found. 
  private List<Account> performSearch(string searchString) {

    String soql = 'select id, name from account';
    if(searchString != '' && searchString != null)
      soql = soql +  ' where name LIKE \'%' + searchString +'%\'';
    soql = soql + ' limit 25';
    System.debug(soql);
    return database.query(soql); 

  }
  
  // save the new account record
  public PageReference saveAccount() {
    insert account;
    // reset the account
    account = new Account();
    return null;
  }
  
  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }
    
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }
    
    
    public list<conAccount> getShow(){
        for(Account coObj:[select id,name from Account LIMIT 10]){
            System.debug('==coObj=='+coObj);
            contactList.add(new conAccount(coObj,allbool));
        }
        System.debug('==contactList=='+contactList);
        return contactList;
    }
    
    public void inIt() {
        list<Account> selectedContact = new list<Account>();
        lookUp = '';
        for(conAccount conObj : contactList) {
            if(conObj.check != false){
                system.debug('conObj.con'+conObj.con);
                selectedContact.add(conObj.con);
                lookUp += conObj.con.name + ' ';
                system.debug('lookUp::'+lookUp);
                contactids.add(conObj.con.id);
            }
        }
        system.debug('selectedContact::'+selectedContact);
        bool = true;
    }
    
    public class conAccount {
        public Account con{get;set;}
        public boolean check{get;set;}
        public conAccount(Account c, boolean boo){ 
             System.debug('==c=='+c);
            System.debug('==boo=='+boo);
            con = c; 
            check = boo; 
        }
    }


 
}