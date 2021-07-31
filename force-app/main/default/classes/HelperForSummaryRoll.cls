public class HelperForSummaryRoll {
    public static void fact() {
        list<faculties__c> listfact = [SELECT id,FacultieName__c,(SELECT id FROM MyStudents__r) FROM faculties__c];
        for(faculties__c factcount : listfact) {
            factcount.NumberOfStudent__c = factcount.MyStudents__r.size();
        }
        update listfact;
    }

}