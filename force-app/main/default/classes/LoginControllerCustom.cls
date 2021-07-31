public class LoginControllerCustom {

    public PageReference login() {
        return null;
    }


    public String username{get; set;}
    public String password{get; set;}
    
    public PageReference doLogin() {
    
        return Site.login(username,password,'/WelcomePageCommunity');
    }
}