public class BoxIntegrationController {
    
    private String redirectURL = 'https://suresgcommunities-developer-editiohttps://suresh1999-dev-ed.my.salesforce.com/apex/BoxIntegrationVf';
    private String accessToken;
    private String refreshToken;
    public Boolean conditinCheack;
    private String folderPath='0';
    public String folderid {get; set;}
    public transient Blob attacementBody {get; set;}
    public String attaceName {get; set;}
    String authCode='';
    public List<BoxWrapperClass.FileDetails>breadcrum{get;set;}
    public List<BoxWrapperClass.FileDetails>lstOfFolder{get;set;}
    public List<BoxWrapperClass.FileDetails>lstOfFile{get;set;}
    public  transient String RecFileName{get;set;}
    public transient Blob fileData{get;set;}
    public  ForboxIntegration__mdt metadataobj;
    public String folderNa {get; set;}

    public BoxIntegrationController(){
        folderNa = '';
        folderid = '';
        attaceName = '';
        breadcrum = new List<BoxWrapperClass.FileDetails>();
        lstOfFile = new List<BoxWrapperClass.FileDetails>();
        lstOfFolder = new List<BoxWrapperClass.FileDetails>();
        BoxWrapperClass.FileDetails tmp = new BoxWrapperClass.FileDetails('home','0');        
        breadcrum.add(tmp);
    }

    public PageReference getAuthCode(){
        metadataobj  = [SELECT  boxClientID__c, boxSecretCode__c FROM ForboxIntegration__mdt where DeveloperName = 'ForBoxClientIdAndSecretCode'];
        PageReference pg;       
        HttpResponse response;      
        List<Community__c> comunity = [select UserId__c from Community__c where UserId__c = :UserInfo.getUserId()];
        Community__c singleCommunityRec = new Community__c();
        BoxWrapperClass.DropBoxAccessTokenResponse tokenresponse = new BoxWrapperClass.DropBoxAccessTokenResponse();

        if(comunity.size()==0){
             conditinCheack=true;
            pg = BoxIntegrationServiceClass.getAuthCode(metadataobj, redirectURL);
            authCode = ApexPages.currentPage().getParameters().get('code');
            System.debug('authcode : ' + authcode);
            if(authcode!=null && authcode!=''){             
                response = BoxIntegrationServiceClass.getAccessToken(metadataobj,  authcode);
                System.debug('Controller response : ' + response.getBody());
                tokenresponse = (BoxWrapperClass.DropBoxAccessTokenResponse)JSON.deserialize(response.getBody(), BoxWrapperClass.DropBoxAccessTokenResponse.class);
                accessToken = tokenresponse.access_token;
                singleCommunityRec.boxRefreshtoken__c = tokenresponse.refresh_token;
                singleCommunityRec.UserId__c = UserInfo.getUserId();                
                response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
                BoxWrapperClass.ResponseWrapper lstOfFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
                diffrentiateFileFolder(lstOfFileFolder);
                insert singleCommunityRec;
                return null;
            }
            else{
                return pg;
            }

        }
        else{/*User id exists*/
            conditinCheack=false;
            singleCommunityRec = [select boxRefreshtoken__c from Community__c where UserId__c = :UserInfo.getUserId() Limit 1];
            System.debug('Controller : singleCommunityRec : ' + singleCommunityRec);
            if(singleCommunityRec.boxRefreshtoken__c == null ||  singleCommunityRec.boxRefreshtoken__c==''){                                
                pg = BoxIntegrationServiceClass.getAuthCode(metadataobj, redirectURL);
                authCode = ApexPages.currentPage().getParameters().get('code');
                System.debug('authcode : ' + authcode);
                if(authcode!=null && authcode!=''){             
                    response = BoxIntegrationServiceClass.getAccessToken(metadataobj,  authcode);
                    System.debug('Controller response : ' + response.getBody());
                    if(Test.isRunningTest()) {                
                    tokenresponse = (BoxWrapperClass.DropBoxAccessTokenResponse)JSON.deserialize(response.getBody(), BoxWrapperClass.DropBoxAccessTokenResponse.class);
                    accessToken = tokenresponse.access_token;
                    singleCommunityRec.boxRefreshtoken__c = tokenresponse.refresh_token;
                    singleCommunityRec.UserId__c = UserInfo.getUserId();                
                    response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
                    BoxWrapperClass.ResponseWrapper lstOfFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
                    diffrentiateFileFolder(lstOfFileFolder);
                    upsert singleCommunityRec UserId__c;
                    }
                    return null;
                }
                else{
                    return pg;
                }
            }
            else{
                singleCommunityRec = [select boxRefreshtoken__c from Community__c where UserId__c = :UserInfo.getUserId() Limit 1];
                if(singleCommunityRec.boxRefreshtoken__c==null || singleCommunityRec.boxRefreshtoken__c==''){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Error, 'RefreshToken token not found : '));
                    return null;
                }
                else{
                    singleCommunityRec = [select boxRefreshtoken__c from Community__c where UserId__c = :UserInfo.getUserId() Limit 1];
                    refreshToken = singleCommunityRec.boxRefreshtoken__c;
                    System.debug('refreshToken : ' + refreshToken);
                    response = BoxIntegrationServiceClass.getNewAccessToken(metadataobj, refreshToken);
                    
                    tokenresponse = (BoxWrapperClass.DropBoxAccessTokenResponse)JSON.deserialize(response.getBody(), BoxWrapperClass.DropBoxAccessTokenResponse.class);
                    accessToken = tokenresponse.access_token;
                    singleCommunityRec.boxRefreshtoken__c = tokenresponse.refresh_token;
                    singleCommunityRec.UserId__c = UserInfo.getUserId();    

                    System.debug('Controller response : ' + response.getBody());
                    System.debug('Controller : folder path : ' + folderPath + ' ####### : ' + accessToken);
                    response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
                    BoxWrapperClass.ResponseWrapper lstOfFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
                    diffrentiateFileFolder(lstOfFileFolder);
                    upsert singleCommunityRec UserId__c;
                        
                }
                 return null;
                 
            }        

        }   
    }       
    
    public void showSubFolder(){
        folderPath = ApexPages.currentPage().getParameters().get('folderId');
        String folderName = ApexPages.currentPage().getParameters().get('folderName');
        HttpResponse response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
        BoxWrapperClass.ResponseWrapper lstOfFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
        diffrentiateFileFolder(lstOfFileFolder);
        BoxWrapperClass.FileDetails tmp = new BoxWrapperClass.FileDetails(folderName, folderPath);
        breadcrum.add(tmp);
    }

    public void navigationUsingBreadcrum(){
        Integer i=0;
        folderPath = ApexPages.currentPage().getParameters().get('folderId');
        System.debug('Folder Path : ' + folderPath);
        List<BoxWrapperClass.FileDetails> tmp = new List<BoxWrapperClass.FileDetails>();
        tmp.addAll(breadcrum);

        for( ; i<breadcrum.size(); i++){
            if(folderPath==breadcrum[i].id){
                break;
            }
        }
        breadcrum.clear();

        for(Integer j=0; j<=i; j++){
            breadcrum.add(tmp[j]);
        }
        HttpResponse response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
        BoxWrapperClass.ResponseWrapper tmpFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
        diffrentiateFileFolder(tmpFileFolder);
    }

    public void deleteFileFolder(){
        folderPath = ApexPages.currentPage().getParameters().get('folderId');
        String fType = ApexPages.currentPage().getParameters().get('fType');
        System.debug('fType : ' + fType);
        HttpResponse response = BoxIntegrationServiceClass.deleteFileFolder(folderPath, accessToken, fType);        
        System.debug('Folder Path : ' + folderPath);    
        folderPath = breadcrum[breadcrum.size()-1].id;  
        response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
        BoxWrapperClass.ResponseWrapper tmpFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
        diffrentiateFileFolder(tmpFileFolder);  
    }

    public void diffrentiateFileFolder(BoxWrapperClass.ResponseWrapper fileFolder){
        lstOfFolder.clear();
        lstOfFile.clear();
        BoxWrapperClass.ItemCollection fr = fileFolder.item_collection;
        for(BoxWrapperClass.FileDetails fd : fr.entries){
            if(fd.type == 'folder'){
                lstOfFolder.add(fd);
            }
            else{
                lstOfFile.add(fd);
            }
        }                   
    }


    /*public void showFolder() {
        HttpResponse res=BoxIntegrationServiceClass.filesAndFolderget(folderid,wrapperclassobject.access_Token);
        box=(BoxWrapperClass.Boxff) System.JSON.deserialize(res.getBody(),BoxWrapperClass.Boxff.class);
        System.debug('box'+box);
        
        for(BoxWrapperClass.Entry r:Box.entries){
            if(r.type=='file') {
                lstOfFile.add(r);
            } 
            else {
                 lstOfFolder.add(r);
            } 
        }
            
        System.debug('listoffile'+listoffile); 
    }*/


    public void downloadFile(){
        folderPath = ApexPages.currentPage().getParameters().get('fileId');
        System.debug('Id : ' + folderPath);
        BoxIntegrationServiceClass.downloadFile(folderPath, accessToken);
    }




    public void createFolder(){
       // String folderName = ApexPages.currentPage().getParameters().get('folderName');
        BoxIntegrationServiceClass.createFolder(folderNa, folderPath, accessToken);
        HttpResponse response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
        System.debug(response.getStatusCode() + ' status : ' + response.getStatus());
        if(response.getStatusCode()==409){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Error,'Folder already exists'));
        }
        else{
            BoxWrapperClass.ResponseWrapper tmpFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
            diffrentiateFileFolder(tmpFileFolder);  
        }
    }


    
    public void uploadFile(){
         try {
        BoxIntegrationServiceClass.uploadFile(RecFileName, fileData, folderPath, accessToken);
        HttpResponse response = BoxIntegrationServiceClass.getData(folderPath, accessToken);
        BoxWrapperClass.ResponseWrapper tmpFileFolder = (BoxWrapperClass.ResponseWrapper)JSON.deserialize(response.getBody(), BoxWrapperClass.ResponseWrapper.class);
        diffrentiateFileFolder(tmpFileFolder);  
        }
        catch(Exception e) {
            if(fileData==null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' Please select  file');
                ApexPages.addMessage(myMsg);
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' File size over limit');
                ApexPages.addMessage(myMsg);
            }
        }
    }
    /*public void uploadNewFile() {
         
        try {
            String respense = BoxIntegrationServiceClass.uploadfile(folderid,accessToken,attacementBody,attaceName);
            diffrentiateFileFolder(respense);
        }
        catch(Exception e) {
            if(attacementbody==null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' Please select any file');
                ApexPages.addMessage(myMsg);
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' File size more than limit');
                ApexPages.addMessage(myMsg);
            }
        }
    }*/

    public PageReference viewFile(){
        folderPath = ApexPages.currentPage().getParameters().get('fileId');
        return new PageReference('https://app.box.com/file/'+ folderPath);
    }
}













/*public void uploadNewFile() {
         size=false;
        try {
            BoxWs.uploadfile(folderid,wrapperclassobject.access_Token,attacementBody,attaceName);
            showFolder();
        }
        catch(Exception e) {
            if(attacementbody==null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' Please select any file');
                ApexPages.addMessage(myMsg);
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' File size more than limit');
                ApexPages.addMessage(myMsg);
            }
        }
    }*/