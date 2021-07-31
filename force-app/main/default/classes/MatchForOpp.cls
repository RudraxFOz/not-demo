/* Description  : This Class call by Scheduled apex that update the Opportunity objcet stage field status
* Created by   : 
* 
* Created date : 11-oct-2019
* 
* Version      : V1.0 Created 
*/
global class MatchForOpp implements Schedulable {
    //----- execute the method when Scheduled call this class  and this method call another method ------
    global void execute(SchedulableContext SC) {
      MatchForOppMethod();  
    }
    
    //----- get the opportunity object record with condition---
    public Static void MatchForOppMethod() {
        List<Opportunity> updateOpportunityLst = new List<Opportunity>();
        //---- decrease the 7 days in current date ---
        Date Dat7 = date.today().adddays(-7); 
        for(Opportunity opp : [SELECT Id, StageName, CloseDate FROM Opportunity WHERE StageName != 'Reserved' AND StageName != 'Sold' AND StageName != 'Sold Revised' AND StageName != 'Closed Lost' AND CloseDate =: Dat7 LIMIT 50000]) {
            if(opp.StageName == 'Loss Reason') {
                opp.StageName = 'No Response' ;
            } else {
                opp.StageName = 'Closed Lost' ;
            }
            updateOpportunityLst.add(opp);
        }

        //----- update the opportunity list record ---
        if ( updateOpportunityLst != null && !updateOpportunityLst.isEmpty() ) {
            update updateOpportunityLst ;
        }
    }
}