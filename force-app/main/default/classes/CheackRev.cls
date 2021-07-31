public class CheackRev {
    public static boolean run = true;
    public static boolean runOnce(){
      if(run){
               run=false;
               return true;
      }
      else{
        //   run=true;
            return false;
            
      }
   }
}