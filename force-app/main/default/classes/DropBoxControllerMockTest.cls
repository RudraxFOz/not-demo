@isTest
public class DropBoxControllerMockTest implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest request) {
        DropboxController dropBoxCon = new DropboxController();
        dropBoxCon.code = '543543534';
        System.debug('Request End Point : ' + request.getEndpoint());
        if(request.getEndpoint().contains('https://api.dropbox.com/1/oauth2')) {
            HttpResponse response = new HttpResponse();          
            response.setBody('{"access_token": "Vnj1lt28MDAAAAAAAAAGI2G9gxDPSAOsW4VAX68YcsTBezkF2UGjYPCYUXMYcJJG", "token_type": "bearer", "uid": "1900550912", "account_id": "dbid:AAA-_9e48vjyBOr6YQZt9EP9dT9c6xngrrM"}');
            response.setStatusCode(200);
            return response;
        }


        else if(request.getEndpoint()=='https://api.dropbox.com/2/files/list_folder') {
            HttpResponse response = new HttpResponse();
            response.setBody('{"entries": [{"tag": "folder", "name": "Gyap", "path_lower": "/gyap", "path_display": "/Gyap", "id": "id:II3zn9kP53AAAAAAAAAAOg"}, {"tag": "folder", "name": "cvbcvb", "path_lower": "/cvbcvb", "path_display": "/cvbcvb", "id": "id:II3zn9kP53AAAAAAAAAAyA"}, {"tag": "file", "name": "lok.txt", "path_lower": "/lok.txt", "path_display": "/lok.txt", "id": "id:II3zn9kP53AAAAAAAAAAew", "client_modified": "2019-02-16T10:25:19Z", "server_modified": "2019-02-16T10:25:19Z", "rev": "0114d000000011fed5f60", "size": 25121, "content_hash": "fd97085a81d8d5aaf7cec1dd98fc726babb97bc86275c045e89b10e8218c9ae3"}, {"tag": "file", "name": "1973773-3ec2451d41ffa48c9d16b51b56336f182ac9430c.zip", "path_lower": "/1973773-3ec2451d41ffa48c9d16b51b56336f182ac9430c.zip", "path_display": "/1973773-3ec2451d41ffa48c9d16b51b56336f182ac9430c.zip", "id": "id:II3zn9kP53AAAAAAAAAAZw", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "0118c000000011fed5f60", "size": 616, "content_hash": "88731ecd370cba901e6752c0fa49927aafaf02f8561325eefd52982388d3d06a"}, {"tag": "file", "name": "Account-CSV-Import-Format.csv", "path_lower": "/account-csv-import-format.csv", "path_display": "/Account-CSV-Import-Format.csv", "id": "id:II3zn9kP53AAAAAAAAAAYQ", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "0118d000000011fed5f60", "size": 262, "content_hash": "b45582a772d244ba10a721fc96f6803668b809413fac784a06afb956f6533464"}, {"tag": "file", "name": "aHR0cDovL21lZGlhLmJlc3RvZm1pY3JvLmNvbS9FL0ovMjk3MzA3L29yaWdpbmFsL2Ryb3Bib3gtbG9nby5qcGc=.webp", "path_lower": "/ahr0cdovl21lzglhlmjlc3rvzm1py3jvlmnvbs9fl0ovmjk3mza3l29yawdpbmfsl2ryb3bib3gtbg9nby5qcgc=.webp", "path_display": "/aHR0cDovL21lZGlhLmJlc3RvZm1pY3JvLmNvbS9FL0ovMjk3MzA3L29yaWdpbmFsL2Ryb3Bib3gtbG9nby5qcGc=.webp", "id": "id:II3zn9kP53AAAAAAAAAAcg", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "0118e000000011fed5f60", "size": 6906, "content_hash": "d5ccb3e01ec45ad777e7c921b8b9fe71aa7b5599109884347a37a90ab94ad3e6"}, {"tag": "file", "name": "EAadhaar_550537375541_07122018172534_113875 (1).pdf", "path_lower": "/eaadhaar_550537375541_07122018172534_113875 (1).pdf", "path_display": "/EAadhaar_550537375541_07122018172534_113875 (1).pdf", "id": "id:II3zn9kP53AAAAAAAAAAYg", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "01192000000011fed5f60", "size": 464340, "content_hash": "9a096537e77659a0c8d8879d1c4e0dc708bd59204697feb2ddfe01f80153f3b8"}, {"tag": "file", "name": "GD.txt", "path_lower": "/gd.txt", "path_display": "/GD.txt", "id": "id:II3zn9kP53AAAAAAAAAAhg", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "01193000000011fed5f60", "size": 88, "content_hash": "b2319922673b23b11c185ca1b1e05056566d1bd144fddbd4efb951efe71d9dff"}, {"tag": "file", "name": "Get Started with Dropbox.pdf", "path_lower": "/get started with dropbox.pdf", "path_display": "/Get Started with Dropbox.pdf", "id": "id:II3zn9kP53AAAAAAAAAACg", "client_modified": "2019-02-16T13:53:19Z", "server_modified": "2019-02-16T13:53:19Z", "rev": "01194000000011fed5f60", "size": 1102331, "content_hash": "f7ad488deb7d81790340ecd676fe6e47f0a6064fb99b982685b752d58611c1cb"}, {"tag": "file", "name": "llllll.txt", "path_lower": "/llllll.txt", "path_display": "/llllll.txt", "id": "id:II3zn9kP53AAAAAAAAAAyg", "client_modified": "2019-02-18T04:55:03Z", "server_modified": "2019-02-18T04:55:03Z", "rev": "0121f000000011fed5f60", "size": 4768, "content_hash": "0d2a619bfa3a5f5900a8a0f433d02af45852427c96164e7b1ae00307363302c7"}], "cursor": "AAElY1Xnp-MIB3HTcZJ5slZ0fhIA3BY4GL33re_Nnc6AjncsF5RjFRCeqkK8uepf8W2kK13UkZ6uJibdny6fPFf_b2cDuiGtRzzC57sMlrtwBHTL5h3hps8dMj5U7cPScYjL_JS1jx9S8MhNrVs3e2wDgkpbDhhIjSxDqit9ii8sAA", "has_more": false}');
            return response ;
        }

        else if(request.getEndpoint()=='https://api.dropboxapi.com/2/files/delete') {
            HttpResponse response = new HttpResponse();
            response.setBody('{"tag": "folder", "name": "cvbcvb", "path_lower": "/cvbcvb", "path_display": "/cvbcvb", "id": "id:II3zn9kP53AAAAAAAAAAyA"}');
            return response;

        }
        else if(request.getEndpoint()=='https://api.dropboxapi.com/2/files/create_folder') {
            HttpResponse response = new HttpResponse();
            response.setBody('{"name": "Deep", "path_lower": "/deep", "path_display": "/Deep", "id": "id:II3zn9kP53AAAAAAAAAAyw"}');
            return response;

        }

        else if(request.getEndpoint()=='https://content.dropboxapi.com/2/files/upload') {
            HttpResponse response = new HttpResponse();
            response.setBody('{"name": "llllll.txt", "path_lower": "/llllll.txt", "path_display": "/llllll.txt", "id": "id:II3zn9kP53AAAAAAAAAAyg", "client_modified": "2019-02-18T04:55:03Z", "server_modified": "2019-02-18T04:55:03Z", "rev": "0121f000000011fed5f60", "size": 4768, "content_hash": "0d2a619bfa3a5f5900a8a0f433d02af45852427c96164e7b1ae00307363302c7"}');
            return response;

        }       
        return null;
    }  
}