@isTest
public with sharing class MatchForOppTest {
    static testMethod void PositiveTest(){
        List<Opportunity> insertLst = new List<Opportunity>();
        List<Opportunity> updateLst = new List<Opportunity>();
        Set<String> assertSet = new Set<String>();
        Date Dat7 = date.today().adddays(-7);
        for(Integer i=1; i <= 200; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'LossName '+ i;
            if(i == 100) {
                opp.StageName = 'Loss Reason';
            } else {
                opp.StageName = 'Reserved';
            }
            opp.CloseDate = Dat7 ;
            insertLst.add(opp);
            assertSet.add(opp.StageName);
        }
        insert insertLst ;

        for(Opportunity opp : insertLst) {
            if(opp.StageName == 'Loss Reason') {
                opp.StageName = 'No Response' ;
            } else {
                opp.StageName = 'Closed Lost' ;
            }
            updateLst.add(opp);
        }
        update updateLst ;

        Test.StartTest();
            MatchForOpp oppObj = new MatchForOpp();
            String sch = '0 0 23 * * ?';
            system.schedule('Test Territory Check', sch, oppObj); 
            MatchForOpp.MatchForOppMethod();
        Test.stopTest();
        for(Opportunity record: updateLst) {
            System.assert(!assertSet.contains(record.StageName));
        }
    }  
}