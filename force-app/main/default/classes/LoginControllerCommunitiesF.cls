global with sharing class LoginControllerCommunitiesF {
    global LoginControllerCommunitiesF () {}

    // Code we will invoke on page load.
    /**global PageReference forwardToAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }*/
    global PageReference forwardToAuthPage() {
       String startUrl = System.currentPageReference().getParameters().get('startURL');
       String displayType= System.currentPageReference().getParameters().get('display');
       
      return Network.forwardToAuthPage(startUrl ,displayType);
    }
    global PageReference forwardToCustomAuthPage() {
        
        return new PageReference('/LoginPageCustomF'); 
    }
}