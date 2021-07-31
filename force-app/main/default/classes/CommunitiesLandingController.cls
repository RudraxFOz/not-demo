public with sharing class CommunitiesLandingController {

    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {
        return Network.communitiesLanding();
    }

    public PageReference forwardToCustomAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return new PageReference('/VfForLanding');
    }

    public CommunitiesLandingController() {}
}