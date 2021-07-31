public class Controller1{
    public String inputText1 {get;set;}
    public Controller1(){
    }
    public pageReference GoToPage2(){
        PageReference pf = new PageReference('/apex/pagetwo?att='+inputText1);
        return pf;
    }
}