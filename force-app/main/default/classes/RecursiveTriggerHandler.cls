public class RecursiveTriggerHandler {
	public static Boolean isFirstTime = true;  
    public static Boolean isUndeleteValue = true;  
     Private 	 String  isUndeleteValue1 = 'true'; 
    
    
    public Static void onlyForTestPur(List<String> listCon){
       // RecursiveTriggerHandler
       // 
        
            TesttttttttttClasssssss.onlyForTestPur1222(listCon);
    }
    
    @future
    public Static void onlyForTestPur1(List<String> listCon1){
       TesttttttttttClasssssss.onlyForTestPur11(listCon1);
    }
    
    
    @future
    public Static void onlyForTestPur1222(List<String> listCon1){
       //TesttttttttttClasssssss.onlyForTestPur11(listCon1);
       System.debug('Come==Here==Futurr==');
    }
    
    
     class InnerRecursiveTriggerHandler {
        Private String innerVar = 'ComeToTest'; 
        RecursiveTriggerHandler obj = new RecursiveTriggerHandler();
        //obj.isUndeleteValue1 = false;
        //this.obj.isUndeleteValue1 = 'false';
        String s1 = obj.isUndeleteValue1 + 'appendedStringBits';
        public void someInnerMethod() {
      		//String s = obj.isUndeleteValue1 + 'appendedStringBits';
      	// do something more useful
    	}
        //RecursiveTriggerHandler.isUndeleteValue1 = false;
    }
    RecursiveTriggerHandler.InnerRecursiveTriggerHandler objInner = new RecursiveTriggerHandler.InnerRecursiveTriggerHandler();
    String valueStr = objInner.innerVar;
    
}