public with sharing class DropboxController {
    public String code {get; set;}
    public String accesstoken ;
   /* public String dropboxAppKey = '7w8nl9en3mjgu4o';
    public String dropboxAppSercet = 't42vdmxd9jr6eem';*/
    public String reUri = 'https://suresgcommunities-developer-edition.ap4.force.com/apex/DropboxPage';
    public List<DropboxWrapperClass.FileDetails> listOfFolder {get; set;}
	public List<DropboxWrapperClass.FileDetails> listOfFile {get; set;}
	public String nameOfSelectedFolder {get; set;}
	public String idOfTheFolder {get; set;}
	public String forCreateFloder ;
	public String nameOfCreateFolder {get; set;}
	public String nameOfDeleteFolder {get; set;}
	public List<DropboxWrapperClass.WrapperForBreadKarm> bedkarm {get; set;}
    public  FordropboxIntegration__mdt metadataobj;
    public List<sobject> recordList{get;set;}
	public String nameOfDownloadFile{get; set;}
	public String nameOfGridKarmFolder {get; set;}
	public String idOfFolderOnGread {get; set;}
	public String mainVarForPath {get; set;}
	public transient Blob file {get;  set;}
	public String stringForUploadFile ;
	public String nameOfFile {get;  set;}
    public String nameOfViewFile {get; set;}
    public DropboxController() {
    	nameOfDownloadFile = '';
    	nameOfFile = '';
    	idOfFolderOnGread ='';
    	idOfTheFolder = '';
    	nameOfGridKarmFolder = '' ;
    	stringForUploadFile = '';
    	mainVarForPath = '';	
    	bedkarm = new List<DropboxWrapperClass.WrapperForBreadKarm>();
    	nameOfDeleteFolder = '';
    	nameOfCreateFolder = '';
    	forCreateFloder = '';
    	nameOfSelectedFolder = 'Home';
    	accesstoken = '';  	
    	listOfFolder = new List<DropboxWrapperClass.FileDetails>();
    	listOfFile = new List<DropboxWrapperClass.FileDetails>();
        System.debug(code);
        breadKarmAddFuction();
    }
    
    public PageReference callAuthCode() {
        //DropboxServiceController dropboxService = new DropboxServiceController();    
        metadataobj   = [SELECT  dropboxAppKey__c, dropboxAppSercet__c FROM FordropboxIntegration__mdt where DeveloperName = 'ForDropboxClientIdAndSecretCode'];
        /*recordList=new List<sobject>();
        recordList=[select DropboxAccessToken__c from DropboxIntegration__c where userid__c=:userid ];*/
        PageReference pg = DropboxServiceController.callForAuthCode(metadataobj, reUri);
        code = ApexPages.currentPage().getParameters().get('code') ;
        System.debug(pg);
        if(code != '' && code != null) {
            System.debug(code);
       		accessToken() ;
       		return null;
     	}
     	else {
    		return pg ;
     	}  
    }

    public void accessToken() {
        String respons = DropboxServiceController.callForAccessToken(metadataobj, reUri, code);
        System.debug(respons);
        if( !String.isEmpty(respons) ) {
            DropboxWrapperClass.AccessTokenWrapper accessTokenObj = (DropboxWrapperClass.AccessTokenWrapper)JSON.deserialize( respons, DropboxWrapperClass.AccessTokenWrapper.class);
            accesstoken = accessTokenObj.access_token;
            showFolderandFiles();
        }
   }

    public void showFolderandFiles() {
        listOfFolder = new List<DropboxWrapperClass.FileDetails>();
        listOfFile = new List<DropboxWrapperClass.FileDetails>();
        String respons = DropboxServiceController.callForShowFolderandFiles(accesstoken, mainVarForPath); 
        DropboxWrapperClass.AllFilesAndFoldersWrapper fildsAndFolder = (DropboxWrapperClass.AllFilesAndFoldersWrapper)JSON.deserialize( respons, DropboxWrapperClass.AllFilesAndFoldersWrapper.class);  	
        System.debug(fildsAndFolder);
       	for(DropboxWrapperClass.FileDetails allFildAndFolder : fildsAndFolder.entries) {
       		if(allFildAndFolder.tag == 'folder') {
       			listOfFolder.add(allFildAndFolder);
       		}
       		else {
       			listOfFile.add(allFildAndFolder);
       		}
       	}
    }

    public void deleteFolderAndFileFuction() {
   		nameOfDeleteFolder = '/'+nameOfDeleteFolder ;
        String respons = DropboxServiceController.callForDeleteFolderAndFileFuction(accesstoken, mainVarForPath, nameOfDeleteFolder);	
        DropboxWrapperClass.UploadDeleteAndCreate uploadedFile = (DropboxWrapperClass.UploadDeleteAndCreate)JSON.deserialize( respons, DropboxWrapperClass.UploadDeleteAndCreate.class);
        showFolderandFiles();
    }

    public void createFloderFuction() {
        System.debug(nameOfCreateFolder);
   		nameOfCreateFolder = '/'+nameOfCreateFolder ;   	
        String respons = DropboxServiceController.callForCreateFloderFuction(accesstoken, mainVarForPath, nameOfCreateFolder);
        System.debug(respons);	 		
        DropboxWrapperClass.UploadDeleteAndCreate uploadedFile = (DropboxWrapperClass.UploadDeleteAndCreate)JSON.deserialize( respons, DropboxWrapperClass.UploadDeleteAndCreate.class);
        nameOfCreateFolder ='';
        showFolderandFiles();
    }

    public void uploadFileFuction() {
        try {
            System.debug(nameOfFile);
    		nameOfFile = '/'+nameOfFile ;   	
        	String respons = DropboxServiceController.callForUploadFileFuction(accesstoken, mainVarForPath, nameOfFile, file);
            DropboxWrapperClass.UploadDeleteAndCreate uploadedFile = (DropboxWrapperClass.UploadDeleteAndCreate)JSON.deserialize( respons, DropboxWrapperClass.UploadDeleteAndCreate.class);      
            showFolderandFiles();
        }
        catch(Exception e) {
            if(file==null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' Please select  file');
                ApexPages.addMessage(myMsg);
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,' File size out of limit');
                ApexPages.addMessage(myMsg);
            }
        }
	}
    public void breadKarmRemoveFuction() {
        List<DropboxWrapperClass.WrapperForBreadKarm> copyOfGreadKarm = new List<DropboxWrapperClass.WrapperForBreadKarm>();
        copyOfGreadKarm.addAll(bedkarm);
        for(Integer i=copyOfGreadKarm.size()-1; i>0; i--) {     	
        	if(copyOfGreadKarm[i].name == nameOfGridKarmFolder &&  copyOfGreadKarm[i].id == idOfFolderOnGread) {
        		break;
        	}
        	bedkarm.remove(i);
        }
    	showFolderandFiles();
    }

    public void breadKarmAddFuction() {
    	DropboxWrapperClass.WrapperForBreadKarm demo = new DropboxWrapperClass.WrapperForBreadKarm();
    	demo.Id = idOfTheFolder;
    	demo.name = nameOfSelectedFolder ;
    	demo.path_lower = mainVarForPath ;
    	bedkarm.add(demo);
    }


    public PageReference viewFile() {
        PageReference pg  = DropboxServiceController.callForViewFile(mainVarForPath, nameOfViewFile);
        //PageReference pgg  = new PageReference('/apex/NewPageForViewFile');     
        return pg;

    }


    public void downloadFile() {
        String  respons  = DropboxServiceController.callForDownloadFile(accesstoken, mainVarForPath, nameOfFile);
        System.debug('This is download respons:'+respons);

    }
        


}