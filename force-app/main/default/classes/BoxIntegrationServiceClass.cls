/*public class BoxIntegrationServiceClass {
 
    public  static  PageReference getcode(ForboxIntegration__mdt temp,String pageurl) {
        PageReference pageredirect;
        System.debug('temp.boxClientID__c : ' + temp.boxClientID__c);
        pageredirect = new PageReference('https://account.box.com/api/oauth2/authorize?response_type=code&client_id='+ temp.boxClientID__c +'&redirect_uri='+ pageurl);
        return   pageredirect;  
    }
    
    public static HttpResponse accessTokenFromRefreshToken(ForboxIntegration__mdt temp,String pageurl,List<sobject>recordList){
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = ' https://api.box.com/oauth2/token';
        String refreshtoken = '';
        req.setEndpoint(endPointValue);
        Integration__c intObj = (Integration__c)recordList[0];
        String refaccess = (String)intObj.get('Refreshtoken__c');
        System.debug('description'+refaccess);
            //String refreshtoken = intObj.get('Refreshtoken__c');
       req.setbody( 'grant_type=refresh_token'  + '&client_id=' + EncodingUtil.urlEncode(temp.boxClientID__c, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(temp.boxSecretCode__c, 'UTF-8') + '&redirect_uri=' + EncodingUtil.urlEncode(pageurl, 'UTF-8') + '&refresh_token=' +EncodingUtil.urlEncode(refaccess, 'UTF-8'));   
        req.setMethod('POST'); 
       HttpResponse res = h.send(req);
      return res;
     }
    
    public static  HttpResponse accessTokenFromAuthCode(ForboxIntegration__mdt temp,String pageurl,String authcode){
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = ' https://api.box.com/oauth2/token';
        String refreshtoken = '';
        req.setEndpoint(endPointValue);
        req.setbody( '&grant_type=' + EncodingUtil.urlEncode('authorization_code', 'UTF-8') + '&code=' + EncodingUtil.urlEncode(authcode, 'UTF-8') + '&client_id=' + EncodingUtil.urlEncode(temp.boxClientID__c, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(temp.boxSecretCode__c, 'UTF-8') + '&redirect_uri=' + EncodingUtil.urlEncode(pageurl, 'UTF-8'));
        req.setMethod('POST'); 
        HttpResponse res = h.send(req);
        return res;
    }
    public static HttpResponse filesAndFolderget(String folderId,String accessToken){
        Http h = new Http(); 
        HttpRequest req = new HttpRequest();
        System.debug('folderid'+folderid);
        string endPointValue = 'https://api.box.com/2.0/folders/'+folderId+'/items'; 
        req.setEndpoint(endPointValue);
        req.setHeader('Authorization', 'Bearer ' + accessToken); 
        System.debug('access_Token'+accessToken);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        return res;
     }
     public static void deletefolder(String folderId,String accessToken){
        Http h = new Http(); 
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://api.box.com/2.0//folders/'+folderId+'?recursive=true/item'; 
        req.setEndpoint(endPointValue);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setMethod('DELETE');
        HttpResponse res = h.send(req);
     }
     public static void deleteFile(String folderId,String accessToken) {
        Http h = new Http(); 
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://api.box.com/2.0//files/'+folderId+'?recursive=true/item'; 
        req.setEndpoint(endPointValue);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setMethod('DELETE');
        HttpResponse res = h.send(req);
     }
     public static void createFolder(String folderId,String accessToken,String foldername) {
        Http h = new Http(); 
        System.debug('foldelid'+folderid);
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://api.box.com/2.0/folders'; 
        System.debug('endPointValue'+endPointValue);
        req.setEndpoint(endPointValue);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        String body= '{"name": "'+foldername+'", "parent": {"id":"'+folderId+'"}}';
        System.debug(body);
        req.setBody(body);
        HttpResponse res = h.send(req);
        System.debug('res'+res.getBody());
        if(res.getStatusCode()==400){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Folder name has exceeded its limit.');
            ApexPages.addMessage(myMsg);
        }
      }
    
     public static void uploadfile(String folderId,String accessToken,Blob attacementBody,String attaceName) {
          String boundary = '----------------------------741e90d31eff';
          String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attaceName+'";\nContent-Type: multipart/form-data;'+'\nnon-svg='+True;
          String footer = '--'+boundary+'--';            
          String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
          HttpResponse res;
          String strFileId;
          while(headerEncoded.endsWith('=')) {
            header+=' ';   
            headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
          }
          String bodyEncoded = EncodingUtil.base64Encode(attacementBody);
          Blob bodyBlob = null;
          String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
          // GW: replacement section to get rid of padding without corrupting data
          if(last4Bytes.endsWith('==')) {
            last4Bytes = last4Bytes.substring(0,2) + '0K';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);    
           }
            else if(last4Bytes.endsWith('=')) {
              last4Bytes = last4Bytes.substring(0,3) + 'N';
                bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                footer = '\n' + footer;
                String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);               
            }
            else { 
                footer = '\r\n' + footer;
                String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
            }
            String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+folderId;
            HttpRequest req = new HttpRequest();
            req.setHeader('Content-Type','multipart/form-data;non_svg='+True+';boundary='+boundary);
            req.setMethod('POST');
            req.setEndpoint(sUrl);
            req.setBodyAsBlob(bodyBlob);
            req.setTimeout(60000);
            req.setHeader('Authorization', 'Bearer '+accessToken);
            req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
            Http http = new Http();
            system.debug('*****size****'+req.getBodyAsBlob().size());
            res = new HttpResponse();
            System.debug('upload'+res.getBody());
            res.setStatusCode(201);
            res = http.send(req);    
    }
   
   
}*/










public class BoxIntegrationServiceClass {
  public static PageReference getAuthCode( ForboxIntegration__mdt metadataobj, String redirectURL){
    PageReference pg = new PageReference('https://account.box.com/api/oauth2/authorize?response_type=code&client_id=' + metadataobj.boxClientID__c + '&redirect_uri='+ redirectURL + '&state=root_readwrite');
    return pg;    
  }

  public static HttpResponse getAccessToken(ForboxIntegration__mdt metadataobj , String authCode){
    System.debug('clientId : ' + metadataobj.boxClientID__c  + ' secret @@@@@@@@@ : ' + metadataobj.boxSecretCode__c + ' authCode : ' + authCode);
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('POST');
    request.setEndpoint('https://api.box.com/oauth2/token');    
    request.setBody(
      '&grant_type=authorization_code' +
      '&code=' + authCode +
      '&client_id=' + metadataobj.boxClientID__c  +
      '&client_secret=' + metadataobj.boxSecretCode__c );

    HttpResponse response = http.send(request);
    System.debug('response : ' + response.getBody());
    return response;
  }

   public static HttpResponse getNewAccessToken(ForboxIntegration__mdt metadataobj,  String refreshtoken){
    System.debug('new accessToken : Service : ' + metadataobj.boxClientID__c  + ' ######## ' + metadataobj.boxSecretCode__c + ' @@@@@ : ' + refreshtoken);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.box.com/oauth2/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = 'client_id=' + metadataobj.boxClientID__c  + '&client_secret=' + metadataobj.boxSecretCode__c + '&refresh_token=' + refreshtoken + '&grant_type=refresh_token';
        request.setBody(body);
        HttpResponse response = http.send(request);
        System.debug('Access Token response is : ' + response.getBody());
        return response;
    }

  public static HttpResponse getData(String fId, String accessToken){
    System.debug('Service Fid : ' + fId + ' accessToken : ' + accessToken);
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    request.setEndpoint('https://api.box.com/2.0/folders/'+fId);
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    HttpResponse response = http.send(request);
    System.debug('Service cls Data : ' + response.getBody());
    return response;
  }






  public static HttpResponse deleteFileFolder(String fId, String accessToken, String type){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('DELETE');
    if(type=='folder'){
      System.debug('Folder');
      request.setEndpoint('https://api.box.com/2.0/folders/'+ fId);
    }
    else{
      System.debug('File');
      request.setEndpoint('https://api.box.com/2.0/files/'+ fId); 
    }
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    HttpResponse response = http.send(request);
    System.debug('Del response : ' + response.getBody());
    return response;    
  }

  public static HttpResponse downloadFile(String fileId, String accessToken){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    request.setEndpoint('https://api.box.com/2.0/files/' + fileId + '/content');
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    HttpResponse response = http.send(request);
    
    if(response.getStatusCode()==302){
      System.debug('Download response : ' + response.getBody());  
    }
    else{
      System.debug('Error');
    }
    return response;
  }

  public static HttpResponse createFolder(String folderName, String parent, String accessToken){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('POST');
    request.setEndpoint('https://api.box.com/2.0/folders');
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    String body = '{' + 
            '"name":"' + folderName +
            '", "parent": {"id": "' + 
            parent +
            '"}}';
    request.setBody(body);
    HttpResponse response = http.send(request);
    System.debug('response : ' + response.getBody());
    return response;
  } 

  public static HttpResponse uploadFile(String fileName, Blob fileData, String parent, String accessToken){
     String boundary = '----------------------------741e90d31eff';
     String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+fileName+'";\nContent-Type: multipart/form-data;'+'\nnon-svg='+True;
     String footer = '--'+boundary+'--';  
      String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
       while(headerEncoded.endsWith('=')) {
            header+=' ';   
            headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
          }

         String bodyEncoded = EncodingUtil.base64Encode(fileData);
         Blob bodyBlob = null;
         String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());

      if(last4Bytes.endsWith('==')) {
          last4Bytes = last4Bytes.substring(0,2) + '0K';
          bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
          String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
          bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);    
      }

      else if(last4Bytes.endsWith('=')) {
        last4Bytes = last4Bytes.substring(0,3) + 'N';
          bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
          footer = '\n' + footer;
          String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
          bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);               
      }

      else{ 
          footer = '\r\n' + footer;
          String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
          bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
      }
                       
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('POST');
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    request.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+parent);
    request.setHeader('Content-Type','multipart/form-data;non_svg='+True+';boundary='+boundary);
    String body = '{' + 
            '"name":"' + fileName + '", "parent":{"id":"' + parent + '"}}';
    request.setBody(body);
    request.setBodyAsBlob(bodyBlob);
    request.setHeader('Content-Length',String.valueof(request.getBodyAsBlob().size()));
    request.setTimeout(60*1000);
    HttpResponse response = http.send(request);
    System.debug('upload response : ' + response.getBody());
    return response;
  }
  
}