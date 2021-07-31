public with sharing class MyPageCon {

 		AllInOne__c   c  ;   
        private ApexPages.StandardController controller;
         public MyPageCon(ApexPages.StandardController controller) {
            this.controller = controller;
        
    }
    
    public PageReference saveAndSuccess() {
    insert c;
        if(controller.save() !=null) {
        PageReference successPage = Page.PublicInformationRequestSuccessful;
        successPage.setRedirect(true);
        successPage.getParameters().put('id',controller.getId());
        return successPage;
        } return null; 
    }
}