public with sharing class GoogleDriveController {
	public String UserId{get;set;}
    public String UserName{get;set;}
    private String key='1070960213033-crec7fjd777nth89vt22m0kiu549g5go.apps.googleusercontent.com';
    private String secret = '92ci1TGNJ6jRvzPYk08ZWjOI';
    private String redirectURL='https://suresgcommunities-developer-edition.ap4.force.com/apex/GoogleDriveCommunity';
    private String code='';    
    private String accessToken='';
    public GoogleDriveServiceForCommunity gdService = new GoogleDriveServiceForCommunity();
    Public String folderName{get;set;}
    public String nameOfSelectedFolder {get; set;}
    public String idOfTheFolder {get; set;}
    public String nameOfGridKarmFolder {get; set;}
    public String idOfFolderOnGread {get; set;}
    public List<GoogleDriveWraaperClass.FileDetails>lstOfFolder{get;set;}
    public List<GoogleDriveWraaperClass.FileDetails>lstOfFile{get;set;}
    public List<GoogleDriveWraaperClass.WrapperForBreadKarm> bedkarm {get; set;}
    String folderId='root';  
    String data;
	public GoogleDriveController() {

		idOfTheFolder = '';
        nameOfGridKarmFolder = '';
    	idOfFolderOnGread = '';    
        nameOfSelectedFolder = 'Home';  
        lstOfFile = new List<GoogleDriveWraaperClass.FileDetails>();              
        lstOfFolder = new List<GoogleDriveWraaperClass.FileDetails>();    
        bedkarm = new List<GoogleDriveWraaperClass.WrapperForBreadKarm>();          
        UserId = UserInfo.getUserName();
        UserName = UserInfo.getName(); 
        System.debug('User Id is : ' + UserId + ' get Name : ' + UserInfo.getName());
        breadKarmAddFuction();
		
	}

	public PageReference getAuthCode() {            
        PageReference pg = gdService.getAuthURL(key, redirectURL);   
        code = ApexPages.currentPage().getParameters().get('code');
        System.debug('Auth code is : ' + code);
        if(code!='' && code!=null){   //Get access token via auth code      
            accessToken = gdService.getAccessToken(code, key, secret, redirectURL); 
            /*System.debug('Take accessToken from auth code : ' + accessToken);*/
            if(accessToken!=null && accessToken!='') {
               showFolder('root');
            }
            
            return null;    
        }
        else { /* Get Access token via refresh token if auth code is null */           
            return pg;
        }              
    }  
    /*Get Folder Id from VF page and according to this id Sub folder will be show*/
    public void showSubFolder(){
        folderId = ApexPages.currentPage().getParameters().get('folderId');
        if(folderId==null || folderId==''){
            folderId='root';
        }
        System.debug('Folder Id : ' + folderId);
        showFolder(folderId);
    }

    //Show All the folder according to folder id 
    public void showFolder(String fId) {
    	System.debug(fId);
    	System.debug(folderId);
        lstOfFile.clear();
        lstOfFolder.clear();
        GoogleDriveWraaperClass.AllFilesAndFoldersWrapper lstOfFileFolder = new GoogleDriveWraaperClass.AllFilesAndFoldersWrapper();
        lstOfFileFolder = gdService.getData(fId);
        for(GoogleDriveWraaperClass.FileDetails allFildAndFolder : lstOfFileFolder.files) {
   	 		System.debug(allFildAndFolder);
       		if(allFildAndFolder.mimeType == 'application/vnd.google-apps.folder') {
       			lstOfFolder.add(allFildAndFolder);
       		}
       		else {
       			lstOfFile.add(allFildAndFolder);
       		}
       	}   
    //Show Folder Close    
    }

    public void getFolderName() {        
        folderName = ApexPages.currentPage().getParameters().get('folderName');
        System.debug('Folder Name : ' + folderName);
        System.debug('Folder Id : ' + folderId);
        gdService.createFolder(folderName, folderId);
        showFolder(folderId);
    }   

    public void deleteFolder() {
        String fId=ApexPages.currentPage().getParameters().get('FolderId');        
        gdService.deleteFolder(fId);
        showFolder(folderId);
    }

    public PageReference downloadFile() {
        folderId = ApexPages.currentPage().getParameters().get('fileId');
        System.debug('File id : ' + folderId);
        PageReference pg = new PageReference(gdService.downloadFile(folderId));        
        return pg;
    }

    public PageReference viewFile() {
        folderId = ApexPages.currentPage().getParameters().get('fileId');
        System.debug('File id : ' + folderId);
        PageReference pg = new PageReference(gdService.viewFile(folderId));
        return pg;
    }

    public void uploadFile() {
        String fileName = ApexPages.currentPage().getParameters().get('fileName');
        String fileType = ApexPages.currentPage().getParameters().get('fileType');
        System.debug('fileName : ' + fileName + ' File Type : ' + fileType);
        if(data==null){
            System.debug('Data null');
        }
        else{
            System.debug('Not null : ' + data);
        }
        gdService.uploadFile(fileName, fileType, data, folderId);
    }
    public void getData() {
        data = ApexPages.currentPage().getParameters().get('fileData');                    
    }


    public void breadKarmRemoveFuction() {
    	System.debug('first');
	    List<GoogleDriveWraaperClass.WrapperForBreadKarm> copyOfGreadKarm = new List<GoogleDriveWraaperClass.WrapperForBreadKarm>();
	    copyOfGreadKarm.addAll(bedkarm);
	    System.debug(copyOfGreadKarm);
	    for(Integer i=copyOfGreadKarm.size()-1; i>0; i--) {     
	    System.debug(nameOfGridKarmFolder);	
	    	 System.debug(copyOfGreadKarm[i].name == nameOfGridKarmFolder &&  copyOfGreadKarm[i].id == idOfFolderOnGread);
	    	if(copyOfGreadKarm[i].name == nameOfGridKarmFolder &&  copyOfGreadKarm[i].id == idOfFolderOnGread) {
	    		break;
	    	}
	    	bedkarm.remove(i);
	    }
		showFolder(folderId);
	}

    public void breadKarmAddFuction() {
		GoogleDriveWraaperClass.WrapperForBreadKarm demo = new GoogleDriveWraaperClass.WrapperForBreadKarm();
		demo.Id = idOfTheFolder;
		demo.name = nameOfSelectedFolder ;
		bedkarm.add(demo);
	}
}