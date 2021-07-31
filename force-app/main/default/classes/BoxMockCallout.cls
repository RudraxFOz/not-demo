@isTest
global  class BoxMockCallout implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req){ 
        BoxIntegrationController tc=new BoxIntegrationController();
          // Create a fake response
        if(req.getEndpoint().contains('https://api.box.com/oauth2/token')) {
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"access_token":"nQLb4oWc34IEH4pDdSTU9HSlMFJLnvS3","expires_in":3472,"restricted_to":[],"refresh_token":"cCzhgu0I4aHItcCSN2c3p4esXHlrurSuouzbhNiwgaTfbJwhQ0VRKQ1VnRbxRaha","token_type":"bearer"}');
            return res;
        }
        else if(req.getEndpoint().contains('https://api.box.com/2.0/folders/')){
            HttpResponse res = new HttpResponse();
            res.setBody(' {"total_count":5,"entries":[{"type":"folder","id":"67011794722","sequence_id":"0","etag":"0","name":"suresh"},{"type":"folder","id":"67022275761","sequence_id":"0","etag":"0","name":"suresh1"},{"type":"file","id":"402989621274","file_version":{"type":"file_version","id":"426103465674","sha1":"2071c41084c3676e7cb9cee7b52921c20dd729e1"},"sequence_id":"0","etag":"0","sha1":"2071c41084c3676e7cb9cee7b52921c20dd729e1","name":"apex-07L6F00005W4pWsUAJ.log"},{"type":"file","id":"402902211822","file_version":{"type":"file_version","id":"426009003822","sha1":"df09d6b7ca476256a1d97e60ceb5dbd173319ced"},"sequence_id":"0","etag":"0","sha1":"df09d6b7ca476256a1d97e60ceb5dbd173319ced","name":"CityAndPeapleName.java"},{"type":"file","id":"402902078512","file_version":{"type":"file_version","id":"426008940112","sha1":"37ae3a7dde8c284b150fc04a93ade3c5942b96c6"},"sequence_id":"0","etag":"0","sha1":"37ae3a7dde8c284b150fc04a93ade3c5942b96c6","name":"Email Service.txt"}],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}');
            res.setStatusCode(200);
            return res;   
        }  
        else if(req.getEndpoint()== 'https://api.box.com/2.0/folders'){
            HttpResponse res = new HttpResponse();
            res.setBody(' {"type":"folder","id":"67010561661","sequence_id":"0","etag":"0","name":"suresh","created_at":"2019-02-14T22:58:21-08:00","modified_at":"2019-02-14T22:58:21-08:00","description":"","size":0,"path_collection":{"total_count":1,"entries":[{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"}]},"created_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"modified_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"trashed_at":null,"purged_at":null,"content_created_at":"2019-02-14T22:58:21-08:00","content_modified_at":"2019-02-14T22:58:21-08:00","owned_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"shared_link":null,"folder_upload_email":null,"parent":{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"},"item_status":"active","item_collection":{"total_count":0,"entries":[],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}}');
            res.setStatusCode(400);
            return res;   
        }
        else if(req.getEndpoint().contains('https://upload.box.com/api/2.0/files/content?')){
            
            HttpResponse res = new HttpResponse();
            res.setBody(' {"total_count":1,"entries":[{"type":"file","id":"402747401092","file_version":{"type":"file_version","id":"425846766292","sha1":"3b77652ae056c36e68c7cfebe39676535a71553b"},"sequence_id":"0","etag":"0","sha1":"3b77652ae056c36e68c7cfebe39676535a71553b","name":"TymSAheet.txt","description":"","size":1157,"path_collection":{"total_count":1,"entries":[{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"}]},"created_at":"2019-02-14T23:17:28-08:00","modified_at":"2019-02-14T23:17:28-08:00","trashed_at":null,"purged_at":null,"content_created_at":"2019-02-14T23:17:28-08:00","content_modified_at":"2019-02-14T23:17:28-08:00","created_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"modified_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"owned_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"shared_link":null,"parent":{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"},"item_status":"active"}]}');
            res.setStatusCode(200);
            return res;   
        }
        else if(req.getEndpoint().contains('https://api.box.com/2.0/folders/')){
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            req.setMethod('DELETE');
            return res;   
        }
        else if(req.getEndpoint().contains('https://api.box.com/2.0/files/')){
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            return res;   
        }
        else if(req.getEndpoint()== 'https://api.box.com/2.0/folders'){
        
            HttpResponse res = new HttpResponse();
            res.setBody(' {"type":"folder","id":"67010561661","sequence_id":"0","etag":"0","name":"suresh","created_at":"2019-02-14T22:58:21-08:00","modified_at":"2019-02-14T22:58:21-08:00","description":"","size":0,"path_collection":{"total_count":1,"entries":[{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"}]},"created_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"modified_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"trashed_at":null,"purged_at":null,"content_created_at":"2019-02-14T22:58:21-08:00","content_modified_at":"2019-02-14T22:58:21-08:00","owned_by":{"type":"user","id":"7204665282","name":"Rajat Dua","login":"rajat.dua@briskminds.com"},"shared_link":null,"folder_upload_email":null,"parent":{"type":"folder","id":"0","sequence_id":null,"etag":null,"name":"All Files"},"item_status":"active","item_collection":{"total_count":0,"entries":[],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}}');
            res.setStatusCode(400);
            return res; 
        }
            return null;
} 
}