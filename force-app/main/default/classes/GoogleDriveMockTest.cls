@isTest
global  class GoogleDriveMockTest implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req){ 
        GoogleDriveControllerForCommunity tc=new GoogleDriveControllerForCommunity();
        
        if(req.getEndpoint()=='https://accounts.google.com/o/oauth2/token') {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200); 
            res.setBody('{"access_Token":"ya29.Gly0BjDvyGQTsHW0kM6JlLgRfAQZ9lfzrkU8n0TTaMs0QLyoXk9uYC_tPTOr6svVCJo0qNw81Oz3FLsmO9l4irGHGmTlup9FbIrI5w4oEGOKEgNIsSGDk-h-mGydzg","token_type":"Bearer", "expires_in": 3599, "scope": "https://www.googleapis.com/auth/drive"}');
            return res;
        }
        else if(req.getEndpoint()== 'https://www.googleapis.com/drive/v3/files?'+
                'q=%27'+tc.folderId+'%27%20in%20parents%20and%20trashed=false&orderBy=folder'){
                    HttpResponse res = new HttpResponse();
                    res.setBody('{"files": [ {"id": "1ms-G6to0bxituNtU57C7wB_naQbksgRx", "name": "sHrI","mimeType": "application/vnd.google-apps.folder"},{ "id": "1RMiG9KGQcPNlFhIzWb00uI81RG9vdQOn",  "name": "BeforeInsertTrigger", "mimeType": "application/octet-stream"}]}');
                    res.setStatusCode(200);
                    return res;   
                }
        else if(req.getEndpoint().contains('https://www.googleapis.com/drive/v3/files/')){
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            req.setMethod('DELETE');
            req.setBody('');
            return res;   
        }
        else if(req.getEndpoint().contains('https://www.googleapis.com/drive/v3/files')){
            HttpResponse response = new HttpResponse();
            response.setBody('{"files": [ {"id": "1ms-G6to0bxituNtU57C7wB_naQbksgRx", "name": "sHrI","mimeType": "application/vnd.google-apps.folder"},{ "id": "1RMiG9KGQcPNlFhIzWb00uI81RG9vdQOn",  "name": "BeforeInsertTrigger", "mimeType": "application/octet-stream"}]}');
            return response;
        }
        else if(req.getEndpoint().contains('https://www.googleapis.com/upload/drive/v3/files/?uploadType=multipart')){
            HttpResponse response = new HttpResponse();
            response.setBody('{"kind": "drive#file", "id": "103gfhgfhfghAZd_s","name": "diffcon1.txt","mimeType": "text/plain"}');
            return response;
        }
      
         else if(req.getEndpoint().contains('https://www.googleapis.com/oauth2')) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(400); 
            res.setBody('{"kind": "drive#fileList", "incompleteSearch": false,"files": [ {  "kind": "drive#file", "id": "12JuhYKOofXOtC27NlTkVxAtF_z-ewQB9", "name": "ddffty",  "mimeType": "application/vnd.google-apps.folder" }, { "kind": "drive#file", "id": "1FJwj00OcsNE6jcFsVGVQhh8t5bsN-_4f","name": "ddff", "mimeType": "application/vnd.google-apps.folder"}, {"kind": "drive#file", "id": "103B-ha0Mc1gBCDwijCk3ERHRNEgAZd_s", "name": "diffcon1.txt", "mimeType": "text/plain"}]}');
            return res;
        }
         else if(req.getEndpoint().contains('https://www.googleapis.com/oauth2')) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200); 
            res.setBody('{"kind": "drive#fileList", "incompleteSearch": false,"files": [ {  "kind": "drive#file", "id": "12JuhYKOofXOtC27NlTkVxAtF_z-ewQB9", "name": "ddffty",  "mimeType": "application/vnd.google-apps.folder" }, { "kind": "drive#file", "id": "1FJwj00OcsNE6jcFsVGVQhh8t5bsN-_4f","name": "ddff", "mimeType": "application/vnd.google-apps.folder"}, {"kind": "drive#file", "id": "103B-ha0Mc1gBCDwijCk3ERHRNEgAZd_s", "name": "diffcon1.txt", "mimeType": "text/plain"}]}');
            return res;
        }
        return null;
    }
}