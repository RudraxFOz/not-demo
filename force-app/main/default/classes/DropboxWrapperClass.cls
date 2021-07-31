public  class DropboxWrapperClass {


	public class AccessTokenWrapper {
		public string access_token {get; set;}
 	}


	public class AllFilesAndFoldersWrapper {
		public List<FileDetails> entries {get; set;}		
		public AllFilesAndFoldersWrapper() {
			entries = new List<FileDetails>();
		}
	}

	public class FileDetails {
		public String tag{get; set;}
		public String id{get; set;}
		public String name {get; set;}
		public String path_lower {get; set;}
		
	}

	public class UploadDeleteAndCreate {
		public string name{get; set;}
		public string id{get; set;}
	}
	public class WrapperForBreadKarm {
		public string name{get; set;}
		public string id{get; set;}
		public String path_lower {get; set;}
	}
}