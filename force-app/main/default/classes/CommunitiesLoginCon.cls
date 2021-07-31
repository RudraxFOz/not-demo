global with sharing class CommunitiesLoginCon {


    global CommunitiesLoginCon() { }

    global PageReference forwardToAuthPage() {
       String startUrl = System.currentPageReference().getParameters().get('startURL');
       String displayType= System.currentPageReference().getParameters().get('display');
       
      return Network.forwardToAuthPage(startUrl ,displayType);
    }
    global PageReference forwardToCustomAuthPage() {
        
        return new PageReference('/CustomLoginPage'); 
    }
  }