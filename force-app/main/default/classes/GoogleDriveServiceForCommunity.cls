public class GoogleDriveServiceForCommunity {
    
    public  static  PageReference getCode(GoogleDrive__mdt idAndSecObj , String pageurl) {
        PageReference pageredirect;
        pageredirect = new PageReference('https://accounts.google.com/o/oauth2/v2/auth?'+
                                         'scope=https://www.googleapis.com/auth/drive'+
                                         '&access_type=offline'+
                                         '&include_granted_scopes=true'+
                                         '&state=state_parameter_passthrough_value'+
                                         '&redirect_uri=' + pageurl +
                                         '&response_type=code'+
                                         '&client_id=' + idAndSecObj.GoogleDriveClientId__c);
        return   pageredirect;  
    }
    public static HttpResponse accessTokenFromAuthCode(GoogleDrive__mdt idAndSecObj , String pageurl,String authcode){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://accounts.google.com/o/oauth2/token');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');     
        
        String body = 'code=' + authcode +
            '&client_id=' + idAndSecObj.GoogleDriveClientId__c +
            '&client_secret=' + idAndSecObj.GoogleDriveSecretCode__c + 
            '&redirect_uri=' + pageurl + 
            '&grant_type=authorization_code';
        
        request.setBody(body);
        request.setHeader('Content-length',String.valueOf(body.length()));
        HttpResponse response = http.send(request);
        return response;
    }
    public static String filesAndFolderget(String folderId,String accessToken){
        HttpResponse response;
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint('https://www.googleapis.com/drive/v3/files?'+
                                'q=%27'+folderId+'%27%20in%20parents%20and%20trashed=false&orderBy=folder');
            request.setHeader('Content-Type','Application/json');
            request.setHeader('Authorization', 'Bearer ' + accessToken);
            System.debug('Folder : ' + folderId + ' Acces : ' + accessToken);
            response = http.send(request); 
            System.debug('response'+response);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Bad Request..!!'));
        }
        return response.getBody();
    }
    public static void deletefolder(String folderId,String accessToken){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('https://www.googleapis.com/drive/v3/files/'+folderId);
        request.setHeader('Content-Type','application/json');
        request.setHeader('Authorization','Bearer ' + accessToken);
        request.setTimeout(60*1000);
        HttpResponse response = http.send(request);
        System.debug('Delete response : ' + response.getBody());
    }
    public static void createFolder(String folderId,String accessToken,String foldername){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(' https://www.googleapis.com/drive/v3/files');
        request.setHeader('Content-Type','Application/json');
        request.setHeader('Authorization','Bearer ' + accessToken);
        String messageBody='{"mimeType": "application/vnd.google-apps.folder", "name": '+ '"' + folderName + '","parents":["' + folderId + '"]}';
        request.setBody(messageBody);
        HttpResponse response = http.send(request);
        foldername = '';
        System.debug('Create Folder response : ' + response.getBody());
    }
    public static void uploadfile(String folderId,String accessToken,Blob attacementBody,String attaceName,String filetype) {

        System.debug(attacementBody);
        System.debug(attaceName);
        System.debug(filetype);
        String boundary = '----------4565gfgdg';
        String delimiter = '\r\n--' + boundary +'\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        String bodyEncoded = EncodingUtil.base64Encode(attacementBody);
        System.debug('bodyEncoded'+bodyEncoded);
        String body;
        if(folderId == 'ROOT') {
          body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "name" : "'+ attaceName+'",'+' "mimeType" : "'+ filetype+ '" ,"parents":[{"id":"'+folderId+'"}]}'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
        }
        else {
          body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "name" : "'+ attaceName+'",'+' "mimeType" : "'+ filetype+ '" ,"parents":["'+folderId+'"]}'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
        }
        System.debug(body);
        Http httpObj = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.googleapis.com/upload/drive/v3/files/?uploadType=multipart');
        request.setHeader('Authorization', 'Bearer ' +accessToken);
        request.setHeader('Content-Type', 'multipart/form-data; boundary="'+boundary+'"');
        
        request.setHeader('Content-length', String.valueOf(body.length()));
        request.setBody(body);
        request.setMethod('POST');
        request.setTimeout(60*1000);
        HttpResponse response = httpObj.send(request); 
        String accessTokenString = response.getBody();
        System.debug(accessTokenString);

    }
      public static HttpResponse accessTokenFromRefreshToken(GoogleDrive__mdt idAndSecObj,String pageurl,String refreshtoken){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = 'client_id=' + idAndSecObj.GoogleDriveClientId__c + '&client_secret=' + idAndSecObj.GoogleDriveSecretCode__c + '&refresh_token=' +refreshtoken  + '&grant_type=refresh_token';
        request.setBody(body);
        HttpResponse response = http.send(request);
        System.debug('Access Token response is : ' + response.getBody());
        return response;
     }


     
    public  Static HttpResponse getFileResponse(String foldelid, String accessToken){
       Http http = new Http();
       HttpRequest request = new HttpRequest();
       request.setMethod('GET');
       request.setEndpoint('https://www.googleapis.com/drive/v2/files/'+foldelid);
       request.setHeader('Content-Type','Application/json');
       request.setHeader('Authorization', 'Bearer ' + accessToken);
       request.setTimeout(60*1000);
       HttpResponse response = http.send(request); 
       System.debug('getFileResponse : ' + response.getBody());
       return response;
    }

    public Static String downloadFile(String foldelid, String accesstoken){
       String downloadLink='';
       HttpResponse response = getFileResponse(foldelid, accessToken);       

       JSONParser parser = JSON.createParser(response.getBody());
       while(parser.nextToken()!=null){
            if(parser.getText()=='webContentLink'){
                parser.nextToken();
                downloadLink = parser.getText();
                break;
            }
       }
       if(downloadLink==null || downloadLink==''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'File is not downloadable...!!!'));
            return null;
       }
       else{            
            return downloadLink;
       }
    }
}