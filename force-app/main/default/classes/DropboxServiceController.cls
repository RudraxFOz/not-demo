public with sharing class DropboxServiceController {

	public Static PageReference callForAuthCode(FordropboxIntegration__mdt metadataobj,String reUri) {
		System.debug(metadataobj.dropboxAppKey__c);
		System.debug(reUri);
		PageReference pg = new PageReference('https://www.dropbox.com/1/oauth2/authorize?response_type=code&client_id='+metadataobj.dropboxAppKey__c+'&redirect_uri='+reUri) ;      
     	return pg ;
	}

	public Static String callForAccessToken(FordropboxIntegration__mdt metadataobj,String reUri,String code) {
		String tokenuri = 'https://api.dropbox.com/1/oauth2/token?grant_type=authorization_code&code='+code+'&redirect_uri='+reUri; 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenuri);
        req.setMethod('POST');
        req.setTimeout(60*1000);
        Blob headerValue = Blob.valueOf(metadataobj.dropboxAppKey__c + ':' + metadataobj.dropboxAppSercet__c);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        Http h = new Http();
        String resp;
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        String accessTokenString = res.getBody();
        System.debug(accessTokenString);
		return accessTokenString;
	}

	public Static String callForShowFolderandFiles(String accesstoken, String mainVarForPath) {
		String bodyData = '{\"path\":"'+mainVarForPath+'\"}' ;
    	//forCreateFloder = '';
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropbox.com/2/files/list_folder');
        req.setHeader('Authorization' , 'Bearer'+ ' '+ accesstoken);
        req.setHeader('Content-Type','application/json');        
        req.setbody(bodyData);   
        req.setMethod('POST');	
        Http h = new Http();
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        System.debug(res);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        return allFolderAndFields ;
	}

	public Static String callForDeleteFolderAndFileFuction(String accesstoken, String mainVarForPath, String nameOfDeleteFolder) {
		String bodyData = '{\"path\":"'+mainVarForPath+nameOfDeleteFolder+'\"}' ;
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropboxapi.com/2/files/delete');
        req.setHeader('Authorization' , 'Bearer'+ ' '+ accesstoken);
        req.setHeader('Content-Type','application/json');        
        req.setbody(bodyData);        
        req.setMethod('POST');	        
        Http h = new Http();
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        return allFolderAndFields;
	}

	public Static String callForCreateFloderFuction(String accesstoken, String mainVarForPath, String nameOfCreateFolder) {
        System.debug(accesstoken);
        System.debug(mainVarForPath);
        System.debug(nameOfCreateFolder);
		String bodyData = '{\"path\": \"'+mainVarForPath+nameOfCreateFolder+'\",\"autorename\": false}' ;
        System.debug(bodyData);
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropboxapi.com/2/files/create_folder');
        req.setHeader('Authorization' , 'Bearer'+ ' '+ accesstoken);
        req.setHeader('Content-Type','application/json');        
        req.setbody(bodyData);        
        req.setMethod('POST');	       
        Http h = new Http();
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        System.debug(res);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        System.debug(allFolderAndFields);
        return allFolderAndFields;
	}

	public Static String callForUploadFileFuction(String accesstoken, String mainVarForPath, String nameOfFile, Blob file) {
		HttpRequest req = new HttpRequest();
        System.debug(accesstoken);
        System.debug(mainVarForPath);
        System.debug(nameOfFile);
        System.debug(file);
        req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
        req.setHeader('Authorization' , 'Bearer'+ ' '+ accesstoken);
        req.setHeader('Content-Type','application/octet-stream');  
        req.setHeader('Dropbox-API-Arg','{\"path\":\"'+mainVarForPath+nameOfFile+'\"}');  
       	req.setBodyAsBlob(file);   
        req.setMethod('POST');	        
        Http h = new Http();
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        return allFolderAndFields;
	}


    public Static PageReference callForViewFile(String mainVarForPath, String nameOfViewFile) {
        PageReference pg = new PageReference('https://www.dropbox.com' + mainVarForPath + '?preview=' + nameOfViewFile);
        //PageReference pgg  = new PageReference('/apex/NewPageForViewFile'+pg);   
        return pg ;

    }

    public Static String callForDownloadFile(String accesstoken,String mainVarForPath, String nameOfFile) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String bodyData = '{\"path\":"'+mainVarForPath+nameOfFile+'\"}' ;
        request.setMethod('POST');
        request.setEndpoint('https://api.dropboxapi.com/2/files/get_temporary_link');
        request.setHeader('Authorization', 'Bearer ' + accesstoken);                
        request.setHeader('Content-Type', 'application/json');
       /* String body = '{\"path\":"'+ nameOfFile +'"}';*/
        request.setBody(bodyData);
        /*HttpResponse response = http.send(request);
        System.debug('download File Body : ' + response.getBody());
        return response;*/
        HttpResponse res = new HttpResponse(); 
        res = http.send(request);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        return allFolderAndFields;
    }
}