public class GoogleDriveWraaperClass {
    
     public class BothToken {
        public String access_token;
        public  String refresh_token;
    } 
    public class AllDataList {
        public List<Entry> files;
    }
    public class Entry {
        public String id{get; set;}
		public String name {get; set;}
		public String mimeType {get; set;}	
    }
    public class Wrapperforbreadcrumb {
        public String id{get;set;}
        public String name{get;set;}
        
    }

}