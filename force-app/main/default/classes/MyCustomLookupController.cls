public with sharing class MyCustomLookupController {
   
  public Contact contact {get;set;}
    public string lookUp{get;set;}
  
  public MyCustomLookupController() {
    contact = new Contact();
  }
    
}