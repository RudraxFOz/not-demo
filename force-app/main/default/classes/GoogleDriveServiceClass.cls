public with sharing class GoogleDriveServiceClass {
	public GoogleDriveServiceClass() {
		
	}

	public Static PageReference callForDriveAuth(String key, String secret, String redirect_uri) {
		String keyy = EncodingUtil.urlEncode(key,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = 'https://accounts.google.com/o/oauth2/auth?'+
        'client_id='+keyy+
        '&response_type=code'+
        '&scope=https://www.googleapis.com/auth/drive'+
        '&redirect_uri='+uri;
        PageReference pg = new PageReference(authuri);
        return pg;
	}
	

	public Static String callForAccessToken(String key, String secret, String redirect_uri, String code) {
		HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        String  resp = res.getBody();
        return resp ;
	}

	public Static String callForFolderAndFiles(String folderId, String accessTok) {
		 System.debug(accessTok);
		 System.debug(folderId);
		 HttpRequest req = new HttpRequest();
	     req.setMethod('GET');
	     String endPointValue = 'https://www.googleapis.com/drive/v3/files?q=%27'+folderId+'%27%20in%20parents%20and%20trashed=false&orderBy=folder';
	     System.debug(endPointValue);
	   	 req.setEndpoint(endPointValue);
	   	 req.setHeader('Authorization' , 'Bearer '+ accessTok);
	   	 req.setHeader('Content-Type','application/json'); 
	   	 req.setTimeout(60*1000);
	     Http h = new Http();
	     HttpResponse res = h.send(req);
	     String resp = res.getBody();
	     System.debug(resp);
	     return resp ;
	}

	public Static String callForDeleteFolderAndFileFuction(String folderId, String accessTok) {
		 System.debug(accessTok);
		 System.debug(folderId);
		 HttpRequest req = new HttpRequest();
	     req.setMethod('DELETE');
	     String endPointValue = 'https://www.googleapis.com/drive/v3/files/'+folderId;
	     System.debug(endPointValue);
	   	 req.setEndpoint(endPointValue);
	   	 req.setHeader('Authorization' , 'Bearer '+ accessTok);
	   	 req.setHeader('Content-Type','application/json'); 
	   	 req.setTimeout(60*1000);
	     Http h = new Http();
	     HttpResponse res = h.send(req);
	     String resp = res.getBody();
	     System.debug(resp);
	     return resp ;

	}

	public Static String callForCreateFolderAndFile(String folderId, String accessTok, String nameOfCreateFolder) {
		 System.debug(accessTok);
		 System.debug(nameOfCreateFolder);
		 Http http = new Http();
         HttpRequest request = new HttpRequest();
         request.setMethod('POST');
         request.setEndpoint(' https://www.googleapis.com/drive/v3/files');
         request.setHeader('Content-Type','Application/json');
         request.setHeader('Authorization','Bearer ' + accessTok);
         String messageBody='';
         if(folderId!= 'root'){
            messageBody = '{"mimeType": "application/vnd.google-apps.folder", "name": '+ '"' + nameOfCreateFolder + '","parents":["' + folderId + '"]}';
            System.debug('messageBody : ' + messageBody);
         }
         else{
            messageBody = '{"mimeType":"application/vnd.google-apps.folder", "name": "'+nameOfCreateFolder +'"}';
            System.debug('messageBody : ' + messageBody);
         }
        /*String messageBody = '';
        if(folderId == 'root') { 
            messageBody = '{"mimeType": "application/vnd.google-apps.folder", "name": '+ '"' + folderName+'"' +'}';
        }
        else {
            messageBody = '{"mimeType": "application/vnd.google-apps.folder", "name": '+ '"' + folderName+'","parents":["'+folderId+'"]}';
        }*/
         request.setBody(messageBody);
         HttpResponse response = http.send(request);
	     String resp = response.getBody();
	     System.debug(resp);
	     return resp ;

	}

	public Static String callForUploadFileFuction(String folderId, String accessTok, String nameOfFile, Blob file) {
		String boundary = '----------9889464542212';
		String delimiter = '\r\n--' + boundary + '\r\n';
		String close_delim = '\r\n--' + boundary + '--';
		String bodyEncoded = EncodingUtil.base64Encode(file);
		HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
        req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart');
        req.setHeader('Authorization' , 'Bearer'+ ' '+ accessTok);
        /*req.setHeader('Content-Type','application/octet-stream'); */ 
       /* req.setHeader('Dropbox-API-Arg','{\"path\":\"'+mainVarForPath+nameOfFile+'\"}'); */ 
        String body = delimiter + 'Content-Type: application/json\r\n\r\n' + '{ "title" : "' + nameOfFile + '",' + ' "mimeType" : "' + file + '" }' + delimiter + 'Content-Type: ' + file + '\r\n' + 'Content-Transfer-Encoding: base64\r\n' + '\r\n' + bodyEncoded + close_delim;
       	req.setBodyAsBlob(file);   
       	req.setBody(body);
       	req.setHeader('Content-Type', 'multipart/mixed; boundary="' + boundary + '"');
		req.setHeader('Content-length', String.valueOf(body.length()));
        req.setMethod('POST');	        
        Http h = new Http();
        HttpResponse res = new HttpResponse(); 
        res = h.send(req);
        String allFolderAndFields = res.getBody().replace('.tag', 'tag');
        return allFolderAndFields;
	}








	/*public void createFolder(String folderName, String folderId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(' https://www.googleapis.com/drive/v3/files');
        request.setHeader('Content-Type','Application/json');
        request.setHeader('Authorization','Bearer ' + accessToken);
        String messageBody='';
        if(folderId!= 'root'){
            messageBody = '{"mimeType": "application/vnd.google-apps.folder", "name": '+ '"' + folderName + '","parents":["' + folderId + '"]}';
            System.debug('messageBody : ' + messageBody);
        }
        else{
            messageBody = '{"mimeType":"application/vnd.google-apps.folder", "name": "'+folderName +'"}';
            System.debug('messageBody : ' + messageBody);
        }
       
        request.setBody(messageBody);
        HttpResponse response = http.send(request);
        System.debug('Create Folder response : ' + response.getBody());
    }*/
	

}