@isTest
public class BoxTest {
    
  /*    @isTest static void testGetAccesstokenfromRefreshtoken() {
        
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        BoxIntegrationController ice = new BoxIntegrationController() ;
        ice.getAuthCode();
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
        Community__c  temp=new  Community__c();
        temp.boxRefreshtoken__c='gsdgf';
        temp.userid__c=Userinfo.getUserId(); 
        insert temp;
        test.startTest();
        ic.getAuthCode();
        BoxWrapperClass.FileDetail tex=new  BoxWrapperClass.FileDetail();
        tex.id='fdgf';
        tex.name='fafc';
        tex.mimeType='File';
        test.stopTest();
        
    } */

  /*@isTest static void testGetAccesstokenfromAuthorizecode() {
        
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
        test.startTest();
        ic.getAuthCode();
        test.stopTest();
        
    } */
     @isTest static void testDeleteFile() {
        BoxWrapperClass.DropboxTokenResponse tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
        tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        tokenresponse.access_token = '121';
        ic.deleteFileFolder(); 
        
    } 
    /*  @isTest static void testuploadFile() {
        
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
       BoxWrapperClass.DropboxTokenResponse tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        ic.uploadFile();
          
        Blob bod = Blob.valueOf('==rajatS==');
        ic.attacementbody=bod;
        ic.uploadFile();
          
        //ic.tokenresponse = new BoxWrapperClass.tokenresponse();
        tokenresponse.access_token = '121';
        Blob body = Blob.valueOf('==rajatS==');
        ic.attacementbody=body;
        ic.uploadFile();
        
        Blob bo = Blob.valueOf('=rajatS=');
        ic.attacename='=vdcv=';
        ic.attacementbody=bo;
        ic.uploadFile();
        
         Blob bo1 = Blob.valueOf('rajatS');
        ic.attacename='vdcv';
        ic.attacementbody=bo1;
        ic.uploadFile();
    }
     @isTest static void testDeleteFolder() {
        
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
         BoxWrapperClass.DropboxTokenResponse tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
        //ic.wrapperclassobject = new  BoxWrapperClass.Token();
        tokenresponse.access_token = '121';
        ic.deleteFileFolder();
        
    }
    
     @isTest static void testForBack1() {
        BoxWrapperClass.DropboxTokenResponse tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
       
        tokenresponse.access_token = '121';
         
        //ic.breadcrum = new List<BoxWrapperClass.FileDetails>();
        //BoxWrapperClass.FileDetails temp = new BoxWrapperClass.FileDetails();
        
       /* for(Integer i=0;i<3;i++){
            temp.id='3435'+i;
            temp.name='dsdsd';    
            ic.breadcrum.add(temp);
        }  
     
        ic.navigationUsingBreadcrum();
        
         
    } 
      @isTest static void testCreatefolder() {
          BoxWrapperClass.DropboxTokenResponse tokenresponse = new BoxWrapperClass.DropboxTokenResponse();
        Test.setMock(HttpCalloutMock.class, new BoxMockCallout());
        PageReference pageRef = Page.BoxIntegrationVf;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','2554545454');
        BoxIntegrationController ic = new BoxIntegrationController() ;
       
        tokenresponse.access_token = '121';
        ic.createFolder();
        
    } */
}