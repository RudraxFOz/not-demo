public with sharing class ActionFunctionDemoController {
  
   public blob file { get; set; }
    public String fileName {get; set;}
    public Integer fileSize {get; set;}
    public String contentType {get; set;}
  
  public ActionFunctionDemoController(ApexPages.StandardController controller) {
    fileName = 'Testt';
   // message = 'Try again!!'; // initial message.
   // 
    System.debug('==come for file=='+file);
  }
  
   public void uploadTest() {
            System.debug('==come for file=='+file);
       
   }
     public void insertJobApplicationAndCon() {
        System.debug('Come in Apex=='+file);
          System.debug('Come in fileName=='+fileName);
         
     }

}