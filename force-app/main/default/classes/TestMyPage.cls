public with sharing class TestMyPage{
   	 public Boolean showSection1{get;set;}
     	public Boolean showSection2{get;set;}
     	public Boolean showSection3{get;set;}
    
     	public TestMyPage ()     {
        		 showSection1= false;
        		 showSection2= true;
       		  showSection3 = true;           }
    	public PageReference method2() {
   showSection1= true;
      		  showSection2= false;
        		  showSection3 = true;
       		 return null;                                    }



    public PageReference method1() {
  		 showSection1= false;
     		 showSection2= true;
        		showSection3 = false;
       		 return null;			    }
}