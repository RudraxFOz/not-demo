public class GoogleDriveIntgrationController {

    //Fetched from URL
    private String code ;
    private String accessTok ;
    public String folderId {get; set;}
    public String nameOfSelectedFolder {get; set;}
    public String idOfTheFolder {get; set;}
    public String nameOfGridKarmFolder {get; set;}
    public String idOfFolderOnGread {get; set;}
    public String nameOfCreateFolder {get; set;}
    public String nameOfFile {get;  set;}
    public transient Blob file {get;  set;}
    private string key = '1070960213033-crec7fjd777nth89vt22m0kiu549g5go.apps.googleusercontent.com' ;
    private string secret = '92ci1TGNJ6jRvzPYk08ZWjOI' ;
    private string redirect_uri = 'https://suresgcommunities-developer-edition.ap4.force.com/apex/GoogleDrivePage?core.apexpages.request.devconsole=1' ;
    public List<GoogleDriveWraaperClass.FileDetails> listOfFolder {get; set;}
	public List<GoogleDriveWraaperClass.FileDetails> listOfFile {get; set;}
	public List<GoogleDriveWraaperClass.WrapperForBreadKarm> bedkarm {get; set;}
	
    
    public GoogleDriveIntgrationController() {
    	listOfFolder = new List<GoogleDriveWraaperClass.FileDetails>();
    	listOfFile = new List<GoogleDriveWraaperClass.FileDetails>();
    	bedkarm = new List<GoogleDriveWraaperClass.WrapperForBreadKarm>();
    	idOfTheFolder = '';
    	nameOfCreateFolder = '';
    	nameOfFile = '';
    	idOfFolderOnGread ='';
    	nameOfGridKarmFolder = '' ;
    	nameOfSelectedFolder = 'Home';
    	accessTok = '';
    	folderId = 'root';
    	breadKarmAddFuction();

    }
    
    public PageReference driveAuth() {
    	PageReference pg = GoogleDriveServiceClass.callForDriveAuth(key, secret, redirect_uri);
    	System.debug('PG is : ' + pg);
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
    
        //Getting access token from google
       	String response =  GoogleDriveServiceClass.callForAccessToken(key,secret,redirect_uri,code);
       	System.debug(response);
        GoogleDriveWraaperClass.AccessTokenWrapper accessTokenObj = (GoogleDriveWraaperClass.AccessTokenWrapper)JSON.deserialize( response, GoogleDriveWraaperClass.AccessTokenWrapper.class);
        accessTok = accessTokenObj.access_token ;
        System.debug(accessTok);
        folderAndFiles('root');
   }

    public void showSubFolder(){
        folderId = ApexPages.currentPage().getParameters().get('folderId');
        if(folderId==null || folderId==''){
            folderId='root';
        }
        System.debug('Folder Id : ' + folderId);
        folderAndFiles(folderId);
    }

   public void folderAndFiles(String folderId) { 	
   		System.debug(folderId);
   	 	String response =  GoogleDriveServiceClass.callForFolderAndFiles(folderId, accessTok);
   	 	System.debug(response);
   	 	GoogleDriveWraaperClass.AllFilesAndFoldersWrapper fildsAndFolder = (GoogleDriveWraaperClass.AllFilesAndFoldersWrapper)JSON.deserialize( response, GoogleDriveWraaperClass.AllFilesAndFoldersWrapper.class);
   	 	System.debug('Records : ' + fildsAndFolder);
   	 	for(GoogleDriveWraaperClass.FileDetails allFildAndFolder : fildsAndFolder.files) {
   	 		System.debug(allFildAndFolder);
       		if(allFildAndFolder.mimeType == 'application/vnd.google-apps.folder') {
       			listOfFolder.add(allFildAndFolder);
       		}
       		else {
       			listOfFile.add(allFildAndFolder);
       		}
       	}
     	System.debug('List Of Folder'+listOfFolder);
     	System.debug('List of file'+listOfFile);
   }

  public void deleteFolderAndFileFuction() {
  		System.debug('hello');
 		String response =  GoogleDriveServiceClass.callForDeleteFolderAndFileFuction(folderId, accessTok);
 		System.debug(response);
 		GoogleDriveWraaperClass.UploadDeleteAndCreate fildsAndFolder = (GoogleDriveWraaperClass.UploadDeleteAndCreate)JSON.deserialize( response, GoogleDriveWraaperClass.UploadDeleteAndCreate.class);
 		 folderAndFiles(folderId);
  }

  public void createFolderAndFile() {
  		/*nameOfCreateFolder = '/' + nameOfCreateFolder ;*/
  		System.debug(nameOfCreateFolder);
  		String response =  GoogleDriveServiceClass.callForCreateFolderAndFile(folderId, accessTok, nameOfCreateFolder);
  		System.debug(response);
 		GoogleDriveWraaperClass.UploadDeleteAndCreate fildsAndFolder = (GoogleDriveWraaperClass.UploadDeleteAndCreate)JSON.deserialize( response, GoogleDriveWraaperClass.UploadDeleteAndCreate.class);
 		folderAndFiles(folderId);
  }

  public void uploadFileFuction() {
		//nameOfFile = '/'+nameOfFile ;   	
		System.debug(nameOfFile);
    	String respons = GoogleDriveServiceClass.callForUploadFileFuction(folderId, accessTok, nameOfFile, file);
        GoogleDriveWraaperClass.UploadDeleteAndCreate uploadedFile = (GoogleDriveWraaperClass.UploadDeleteAndCreate)JSON.deserialize( respons, GoogleDriveWraaperClass.UploadDeleteAndCreate.class);      
         folderAndFiles(folderId);
	}

  public void breadKarmRemoveFuction() {
	    List<GoogleDriveWraaperClass.WrapperForBreadKarm> copyOfGreadKarm = new List<GoogleDriveWraaperClass.WrapperForBreadKarm>();
	    copyOfGreadKarm.addAll(bedkarm);
	    for(Integer i=copyOfGreadKarm.size()-1; i>0; i--) {     	
	    	if(copyOfGreadKarm[i].name == nameOfGridKarmFolder &&  copyOfGreadKarm[i].id == idOfFolderOnGread) {
	    		break;
	    	}
	    	bedkarm.remove(i);
	    }
		 folderAndFiles(folderId);
	}

  public void breadKarmAddFuction() {
		GoogleDriveWraaperClass.WrapperForBreadKarm demo = new GoogleDriveWraaperClass.WrapperForBreadKarm();
		demo.Id = idOfTheFolder;
		demo.name = nameOfSelectedFolder ;
		bedkarm.add(demo);
	}

}


//https://www.googleapis.com/auth/drive
//client id : 1070960213033-crec7fjd777nth89vt22m0kiu549g5go.apps.googleusercontent.com
//secret key : 92ci1TGNJ6jRvzPYk08ZWjOI