public class NewClassForContact {
    public static boolean work=true;
    public  static boolean  runWk() {
        if(work) {
            work=false;
            return true;
        }
        else
        {
            work=true;
            return false;
        }
    }

}