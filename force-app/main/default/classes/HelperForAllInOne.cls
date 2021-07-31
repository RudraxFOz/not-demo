public class HelperForAllInOne {
    public static void countAllInOne(AllInOne__c[] all) {
        for(AllInOne__c c : all) {
            c.First_Name__c = 'Shivay';
        }
    }

}