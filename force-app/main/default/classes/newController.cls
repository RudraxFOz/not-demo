public class newController {
    public String currentuser{get;set;}
    public String currentuserId{get;set;}
    public List<Contact> showImage{get; set;}
    public newController() {
        currentuser = userinfo.getFirstName();
        //currentuserId = currentuser.id ;
        showImage = [SELECT Name,Email,(SELECT ContentType FROM Attachments WHERE isPrivate = false order BY LastModifiedDate desc)FROM Contact LIMIT 2];
    }
}