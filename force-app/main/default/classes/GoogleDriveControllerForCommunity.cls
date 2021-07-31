public class GoogleDriveControllerForCommunity {  
    public Transient Blob attacementBody{get;set;}
    public string foldelid{get;set;}
    public GoogleDriveWraaperClass.AllDataList showAllData;
    public List<GoogleDriveWraaperClass.Entry>listoffile{get;set;}
    public List<GoogleDriveWraaperClass.Entry>listoffolder{get;set;}
    public string folderid{get;set;}
    public GoogleDriveWraaperClass.BothToken tokenObj{get;set;} 
    public List<GoogleDriveWraaperClass.Wrapperforbreadcrumb>breadcrumb{get;set;}
    public string codeFromBox{get;set;} 
    public Boolean refreshTokenExpire{get;set;}
    public Boolean conditinCheack;
    public String filetype {get;set;}
    public String attaceName{get;set;}
    public  GoogleDrive__mdt metaObj;
    public List<sobject> ListForRefeToken{get;set;}
    public  String foldername{get;set;}
    public String reUri='https://suresgcommunities-developer-edition.ap4.force.com/apex/GoogleDriveCommunity';
    public  String folderna{get;set;}
  
    
    public GoogleDriveControllerForCommunity(){
        folderid='root';
        breadcrumb=new List<GoogleDriveWraaperClass.Wrapperforbreadcrumb>();
        folderna='Home';
        breadcrumbMethod();
    }
    
    public PageReference googleDriveAuthCode(){
        HttpResponse accessResponse;
        metaObj  = [SELECT GoogleDriveClientId__c, GoogleDriveSecretCode__c FROM GoogleDrive__mdt where DeveloperName = 'ForGoogleDrive'];
        PageReference pageredirect;
        String userid=Userinfo.getUserId();
        ListForRefeToken=new List<sobject>();
        ListForRefeToken=[select GoogleDriveRefreshToken__c from Integration__c where userid__c=:userid And GoogleDriveRefreshToken__c!=null ];
        System.debug(' pageredirect4'); 
        if( ListForRefeToken.size() == 0  ) {
            conditinCheack=true;
            pageredirect =GoogleDriveServiceForCommunity.getCode(metaObj,reUri);
            System.debug(' pageredirect');
            codeFromBox = System.currentPageReference().getParameters().get('code'); 
            System.debug('  codeFromBox'+ codeFromBox);
            if(codeFromBox == null || codeFromBox =='') {  
                return  pageredirect;
            }
            else { 
                System.debug('codeFromBox'+codeFromBox);
                accessResponse=GoogleDriveServiceForCommunity.accessTokenFromAuthCode(metaObj,reUri,codeFromBox);

                String response= accessResponse.getBody();
                System.debug('response'+response);
                tokenObj=(GoogleDriveWraaperClass.BothToken)JSON.deserialize(response, GoogleDriveWraaperClass.BothToken.class);
                System.debug('tokenObj'+tokenObj.access_Token);
                if(tokenObj.access_Token != null & tokenObj.access_Token != '') {
                    showFolder();  
                }   
                
            }
        }     
        else {
            conditinCheack=false;
            Integration__c intObj = (Integration__c)ListForRefeToken[0];
            String refaccess = (String)intObj.get('GoogleDriveRefreshToken__c');
            accessResponse=GoogleDriveServiceForCommunity.accessTokenFromRefreshToken(metaObj,reUri,refaccess);
            if(accessResponse.getStatusCode()==400 || accessResponse.getStatusCode()==401){
              pageredirect =GoogleDriveServiceForCommunity.getCode(metaObj,reUri);
                System.debug(' pageredirect');
                codeFromBox = System.currentPageReference().getParameters().get('code'); 
                System.debug('  codeFromBox'+ codeFromBox);
                if(codeFromBox == null || codeFromBox ==''){  
                    return  pageredirect;
                }
                else { 
                    System.debug('codeFromBox'+codeFromBox);
                    accessResponse=GoogleDriveServiceForCommunity.accessTokenFromAuthCode(metaObj,reUri,codeFromBox);

                    String response= accessResponse.getBody();
                    System.debug('response'+response);
                    tokenObj=(GoogleDriveWraaperClass.BothToken)JSON.deserialize(response, GoogleDriveWraaperClass.BothToken.class);
                    System.debug('tokenObj'+tokenObj.access_Token);
                    if(tokenObj.access_Token != null & tokenObj.access_Token != '') {
                        showFolder();  
                    }   
                
                }  
                    
            }
            String response= accessResponse.getBody();
            tokenObj=(GoogleDriveWraaperClass.BothToken)JSON.deserialize(response, GoogleDriveWraaperClass.BothToken.class);
            System.debug('accessResponse'+accessResponse);
            showFolder(); 
            return null;
        }
        return null; 
    }
    public  void valueSet(){
        Integration__c integrationvriable = new Integration__c();
        integrationvriable.GoogleDriveRefreshToken__c=tokenObj.refresh_token;
        integrationvriable.userid__c=Userinfo.getUserId();
        integrationvriable.Name=Userinfo.getName();
        upsert integrationvriable userid__c; 
        
    }
     public void showFolder() {
        
        String res=GoogleDriveServiceForCommunity.filesAndFolderget(folderid,tokenObj.access_Token);
        System.debug('res'+res);
        showAllData=(GoogleDriveWraaperClass.AllDataList) System.JSON.deserialize(res,GoogleDriveWraaperClass.AllDataList.class);
        System.debug('showAllData'+showAllData);
        listoffile=new List<GoogleDriveWraaperClass.Entry>();
        listoffolder=new List<GoogleDriveWraaperClass.Entry>();
        for(GoogleDriveWraaperClass.Entry r:showAllData.files){
            if(r.mimeType=='application/vnd.google-apps.folder') {
                listoffolder.add(r);
            } 
            else {
                listoffile.add(r);
            } 
        }
        if(conditinCheack){
        valueSet();
        }    
        System.debug('listoffile'+listoffile); 
    }
    public void deleteShowFolder() {
        conditinCheack = false;
        GoogleDriveServiceForCommunity.deleteFolder(foldelid,tokenObj.access_Token);   
        showFolder();     
    }
     public void createNewfolder() {
         conditinCheack = false;
        GoogleDriveServiceForCommunity.createFolder(folderid,tokenObj.access_Token,foldername);
        foldername = '';
        showFolder();     
    }
     public void uploadNewFile() {
        System.debug(attacementBody);
         System.debug(attaceName);
          System.debug(filetype);

        try {
            GoogleDriveServiceForCommunity.uploadfile(folderid,tokenObj.access_Token,attacementBody,attaceName,filetype);
            showFolder();
        }
        catch(Exception e) {
            if(attacementbody==null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' Please select  file');
                ApexPages.addMessage(myMsg);
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' File size over limit');
                ApexPages.addMessage(myMsg);
            }
        }
    }

    public PageReference downloadFile() {
        
        //folderId = ApexPages.currentPage().getParameters().get('fileId');
        System.debug('File id : ' + foldelid);
        PageReference pg = new PageReference(GoogleDriveServiceForCommunity.downloadFile(foldelid, tokenObj.access_Token));        
        return pg;
    }


    public void breadcrumbMethod() {
        conditinCheack = false;
        GoogleDriveWraaperClass.Wrapperforbreadcrumb  temp= new GoogleDriveWraaperClass.Wrapperforbreadcrumb();
        temp.name=folderna;
        temp.id=folderid;
        breadcrumb.add(temp);
        System.debug('breadcrumb'+folderid);   
    }
    public void forBack() {
        List<GoogleDriveWraaperClass.Wrapperforbreadcrumb>removeitem= new List<GoogleDriveWraaperClass.Wrapperforbreadcrumb>();
        removeitem.addAll(breadcrumb);
        for(Integer i=removeitem.size()-1;i>0;i--) {
            if(removeitem[i].id==folderid){
                break;
            }
            System.debug('folder id '+folderid);
            System.debug('Value is ='+removeitem[i]);
            breadcrumb.remove(i); 
        }
        showFolder();
    }
}