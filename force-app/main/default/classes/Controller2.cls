public class Controller2{
    public String inputText2 {get;set;}
    public Controller2(){
        inputText2 = apexpages.currentpage().getparameters().get('att');
    }
}