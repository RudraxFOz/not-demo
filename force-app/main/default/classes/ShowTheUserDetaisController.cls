public with sharing class ShowTheUserDetaisController {


	
	public String username{get;set;}
	public String imageURL{get;set;}
	public String userid{get;set;}
	public String attchName{get;set;}
	public User currentuser{get;set;}
	public String FirstNamef {get;set;}
	public String LastNamef {get;set;}
	public transient blob attchBody{get;set;}
	public attachment objAttachment{get;set;}
	public Contact con;
	public String newPassword{get;set;}
    public String verifyNewPassword{get;set;}
    public String oldpassword{get;set;}
    
	public void check(){
	 username = UserInfo.getName();
	 userid = UserInfo.getUserEmail();
	 System.debug('lending username'+username);
	 	imageURL='/servlet/servlet.FileDownload?file=';
   		con = [Select Id,(select Id from Attachments) from Contact Where Id =: [SELECT Id, ContactId FROM USER Where Id =: UserInfo.getUserId()].ContactId limit 1];
   		System.debug(con.Attachments.size()>0);
	 	if(con.Attachments.size()>0)
    	{
      		imageURL=imageURL+con.Attachments[0].id;
    	}
	}
	/*public void uploadattachment(){
		delete con.attachments[0];
		objAttachment = new Attachment();
		objAttachment.clear();
		objAttachment.body = attchBody;
        objAttachment.ParentId = con.Id;
		objAttachment.name = attchName;
		insert objAttachment;
		check();
	}*/



   /* 
    public String confirmpassword{get;set;}
  
    public String tempId{get;set;}
   
    public ShowTheUserDetaisController(){
        String userid=UserInfo.getUserId();
        username = UserInfo.getName();
        System.debug('lending username'+username);
        imageURL='/servlet/servlet.FileDownload?file=';
        user temp=[SELECT Id,ContactId,Name FROM USER Where Id=:userid];
        System.debug('user'+temp);
        String temp2=temp.ContactId;
        System.debug('temp2'+temp2);
        con = [Select Id,(select Id,parentId,name from Attachments) from Contact Where Id =:temp2 limit 1];
        System.debug('con'+con); 
            
        if(con.Attachments.size()>0)
        {
            //System.debug('con.Attachments.id'+con.Attachments[0].id);
            imageURL=imageURL+con.Attachments[0].id;
            System.debug('UR @@@@@@@@@@@ '+imageURL);
        }
    }*/
    
    


	
  	public PageReference ShowTheUserDetaisControllerF(){   
     	currentuser = [Select Id,Username,FirstName,LastName  from User where Id =: userinfo.getuserId()];
     	System.debug(FirstNamef);
     	System.debug(LastNamef);
     	currentuser.FirstName = FirstNamef ;
     	currentuser.LastName = LastNamef ;
     	update currentuser ;
     	try{
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);
        }
         catch(Exception e){
              ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'invalid value');
                ApexPages.addMessage(myMsg);
        }
     return null;
  	} 

	
}