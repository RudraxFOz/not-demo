public with sharing class FileUploadController{
    //Public data member
    public Transient Blob file {get; set;}
    public String fileName {get; set;}
    //Constructor
    public FileUploadController(ApexPages.StandardController controller) {
        //Initialize
        file = null;
        fileName = '';
    }
    //Method to uploadFile
    public void uploadFile(){
        ContentVersion conVersion = new ContentVersion();
        conVersion.VersionData = file; 
        conVersion.Title = fileName.contains('.') ? fileName.substringBeforeLast('.') : fileName;
        conVersion.PathOnClient = fileName;
        conVersion.ContentLocation = 'S';
        //insert conVersion;
        if(conVersion != null && conVersion.Id != null){
            String conDocumentId = [Select Id,ContentDocumentId From ContentVersion Where Id =: conVersion.Id].ContentDocumentId;
            if(String.isNotBlank(conDocumentId)){
                ContentDocumentLink conDocumentLink = new ContentDocumentLink();
                conDocumentLink.ShareType = 'V';
                conDocumentLink.LinkedEntityId = '0010I00002WwQY6';
                conDocumentLink.ContentDocumentId = conDocumentId;
                //insert conDocumentLink;
            }
        }
    }
}