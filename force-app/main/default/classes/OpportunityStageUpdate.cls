public with sharing class OpportunityStageUpdate {
    @AuraEnabled
    public static void updateStage(String stageName , String recordId){
        Opportunity opp = [Select Id ,StageName from Opportunity where Id=:recordId] ; 
        opp.StageName =stageName ; 
        update opp ;
        
    }
}