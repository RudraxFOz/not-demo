public class DemoForDocumentCss {
    public String imageURL{get;set;}
    public Id documentList1{get;set;}
    public DemoForDocumentCss(){
        imageURL='/servlet/servlet.FileDownload?file=';
        //imageURL1='/servlet/servlet.FileDownload?file=';
        List< document > documentList=[select Id, name from document where Name='TestCSS1'];
        System.debug('documentList=='+documentList);
        documentList1=[select name from document where Name='Updated logo' Limit 1].Id;
        imageURL= imageURL+documentList[0].id;
    }
}