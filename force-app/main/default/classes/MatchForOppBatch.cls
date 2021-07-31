public with sharing class MatchForOppBatch implements Database.Batchable<sObject>, Database.Stateful {
   
    public String queryString = 'SELECT Id, StageName, CloseDate FROM Opportunity ';
    public Database.QueryLocator start(Database.BatchableContext bc) {
        //System.debug('==Dat5=='+Dat5);
        return Database.getQueryLocator(queryString);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope){
        List<Opportunity> oppLst = new List<Opportunity>();
        List<Opportunity> oppLst1 = new List<Opportunity>();
        //Date Dat5 = date.today().adddays(-7); AND CloseDate =:Dat5
        Date Dat5 = date.today().adddays(-7); 
        oppLst = [SELECT Id, StageName, CloseDate FROM Opportunity WHERE StageName != 'Reserved' AND StageName != 'Sold' AND StageName != '	Sold Revised' AND StageName != 'Closed Lost' AND CloseDate =: Dat5];
        System.debug('==scope=='+oppLst);
        //List<Opportunity> oppLst1 = new List<Opportunity>();
        for(Opportunity opp : oppLst) {
            System.debug('==opp=='+opp);
            if(opp.StageName == 'Loss Reason') {
                opp.StageName = 'No Response' ;
            } else {
                opp.StageName = 'Closed Lost' ;
            }
            oppLst1.add(opp);
        }
        update oppLst1;
        System.debug(oppLst1);
    }

    public void finish(Database.BatchableContext BC) {

    }

}