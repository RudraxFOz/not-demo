public class CustomLoginControllerF {

    public PageReference login() {
        return null;
    }
    public String username{get; set;}
    public String password{get; set;}           
    public PageReference doLogin() {
        return Site.login(username,password,'/CommunityWelcomePageF');
    }
}

/*public class LendingCommunityController{
	//constructor
	public String username{get;set;}
	public String imageURL{get;set;}
	public String userid{get;set;}
	public String attchName{get;set;}
	public transient blob attchBody{get;set;}
	 public attachment objAttachment{get;set;}

	Contact con;
    public LendingCommunityController(){
	 
	}
	public void check(){
	 username = UserInfo.getName();
	 userid = UserInfo.getUserEmail();
	 System.debug('lending username'+username);
	 	imageURL='/servlet/servlet.FileDownload?file=';
   		 con = [Select Id,(select Id from Attachments) from Contact Where Id =: [SELECT Id, ContactId FROM USER Where Id =: UserInfo.getUserId()].ContactId limit 1];
	 	if(con.Attachments.size()>0)
    	{
      		imageURL=imageURL+con.Attachments[0].id;
    	}
	}
	public void uploadattachment(){
		delete con.attachments[0];
		objAttachment = new Attachment();
		objAttachment.clear();
		objAttachment.body = attchBody;
        objAttachment.ParentId = con.Id;
		objAttachment.name = attchName;
		insert objAttachment;
		check();
	}

}*/