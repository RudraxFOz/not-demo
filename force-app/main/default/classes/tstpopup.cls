public class tstpopup {     

    public boolean displayPopup {get; set;}     
    
   
    
     public string lookUp{get;set;}
    public list<conContact> contactList{get;set;}
    public boolean allbool{get;set;}
    public string inputValue{get;set;}
    public boolean bool{get;set;}
    public set<id> contactids{get;set;}
    ApexPages.StandardController controller;

    public tstpopup(ApexPages.StandardController con) {
        controller = con; contactList = new list<conContact>();
        bool = false; contactids = new Set<Id>();
    }    
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    

    
 
    
    public class conContact {
        public contact con{get;set;}
        public boolean check{get;set;}
        public conContact(contact c, boolean boo){ con = c; check = boo; }
    }

    public void inIt() {
        list<Contact> selectedContact = new list<Contact>();
        lookUp = '';
        for(conContact conObj : contactList) {
            if(conObj.check != false){
                system.debug('conObj.con'+conObj.con);
                selectedContact.add(conObj.con);
                lookUp += conObj.con.name + ' ';
                system.debug('lookUp::'+lookUp);
                contactids.add(conObj.con.id);
            }
        }
        bool = true;
    }

    public list<conContact> getShow(){
        for(Contact coObj:[select id,name from Contact LIMIT 10]){
            contactList.add(new conContact(coObj,allbool));
        }
        return contactList;
    }

    public PageReference mySave() {
        list<Contact> updateSelectedContact = new list<Contact>();
        id accId = ApexPages.CurrentPage().getparameters().get('id');
        for(Contact co:[select id,name,accountid from Contact where id =: contactids]) {
            co.accountid = accId;
            updateSelectedContact.add(co);
        }
        update updateSelectedContact;
        return null;
    }

    public void closePopup1() {
        bool = false;
    }

    public void add(){
        bool = true;
    }
    
    
  }