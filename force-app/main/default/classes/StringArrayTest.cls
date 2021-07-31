public class StringArrayTest {

    public Static List<String> generateStringArray(Integer n) {
    
        List<String> myArray = new List<String>();
        for(Integer i=0; i<n; i++) {        
            myArray.add('Test '+i);
        }
        System.debug(myArray);
        return myArray;
    }
}