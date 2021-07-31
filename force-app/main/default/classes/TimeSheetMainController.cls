public with sharing class TimeSheetMainController {

    @AuraEnabled
	public static String setTimeSheetRecord(Date sDate, Date eDate){
        String returnTimeSheetId ;
        //If(sDate != null && eDate != null ){
            
                System.debug('==sDate=='+sDate);
                System.debug('==eDate=='+eDate);

                Timesheet__c timesheetObj = new Timesheet__c();
                timesheetObj.Start_Date__c = sDate;
                timesheetObj.End_Date__c = eDate;
                Database.SaveResult srList = Database.insert(timesheetObj, false);
                if (srList.isSuccess()) {
                    returnTimeSheetId =  srList.getId();
                }
                return returnTimeSheetId;
           
                //return false;
           
        //}
       
        // Iterate through each returned result
        // for (Database.SaveResult sr : srList) {
        //     if (sr.isSuccess()) {
        //         // Operation was successful, so get the ID of the record that was processed
        //         System.debug('Successfully inserted account. Account ID: ' + sr.getId());
        //     }
    }
    
    
    @AuraEnabled
	public static void saveTimeSheetItems(List<Timesheet_Line_items__c> ListTimeSheetItems, String TimeSheetid){

        System.debug('==ListTimeSheetItems=='+ListTimeSheetItems);
        System.debug('==TimeSheetid=='+TimeSheetid);
        List<Timesheet_Line_items__c> timeSheetItemList = new List<Timesheet_Line_items__c>();
        For(Timesheet_Line_items__c itemObj : ListTimeSheetItems) {
            Timesheet_Line_items__c obj = new Timesheet_Line_items__c();
                obj.Timesheet__c = TimeSheetid;
                obj.Project_Name__c = itemObj.Project_Name__c;
                obj.Monday__c = itemObj.Monday__c;
                obj.Tuesday__c = itemObj.Tuesday__c;
                obj.Wednesday__c = itemObj.Wednesday__c;
                obj.Thursday__c = itemObj.Thursday__c;
                obj.Friday__c = itemObj.Friday__c;
                obj.Saturday__c = itemObj.Saturday__c;
                obj.Sunday__c = itemObj.Sunday__c;
            timeSheetItemList.add(obj);
        }
        If(timeSheetItemList.Size() > 0){
            insert timeSheetItemList;
        }
    }
}