public class UpdateTaskTriggerHandller {
    public Process__c pro{get;set;} 
    public Decimal deProgressBarWidth {get;set;}
    public String strStatus {get;set;}
    public Integer iCount {get;set;}
    public Boolean bProcess {get;set;}
    public List<String> startToEndDates {get;set;} 
    public List<Date> startToEndDatesForTask {get;set;}
       
    public UpdateTaskTriggerHandller(ApexPages.StandardController controller) { 
        startToEndDates = new List<String>();
        startToEndDatesForTask = new List<Date>();
        Decimal count = 0;
        pro = (Process__c)controller.getRecord();   
        deProgressBarWidth = 0;
        strStatus = 'In Progress...';
        bProcess = true;
        iCount = 0;
        String startDateOfTaskStr = '0';
        Date startDateOfTask ;
        Integer totalDayBetweenFirstAndEnd;
        String endDateOftask = '0';
        for(Process__c process : [SELECT Id, Name , (SELECT Id, Name, Task_Sequence__c, Contact__c,Contact__r.Name, Status__c, Start_Date__c, End_Date__c  FROM TaskChild__r LIMIT 50000) FROM Process__c WHERE Id  =: pro.Id LIMIT 50000]) {
            count = process.TaskChild__r.size();
            for(Task__c task : process.TaskChild__r) {
                if(task.Task_Sequence__c == 1){
                    startDateOfTaskStr = task.Start_Date__c.format();
                    startDateOfTask = task.Start_Date__c;
                }
                if(task.End_Date__c != null){
                    endDateOftask = task.End_Date__c.format();
                }
            }
            Date startDate = date.parse(startDateOfTaskStr);
            Date endDate = date.parse(endDateOftask);
            totalDayBetweenFirstAndEnd = startDate.daysBetween(endDate);
        }
        for( Integer i = 0; i <= totalDayBetweenFirstAndEnd; i++) {
            startToEndDates.add(startDateOfTask.addDays(i).format()); 
            startToEndDatesForTask.add(startDateOfTask.addDays(i)); 
        }
} 



public PageReference checkStatus() {
        // Caluclating Percentage value
        deProgressBarWidth = (iCount != 0 ? (Decimal.valueOf(iCount) > 100 ? 100 : Decimal.valueOf(iCount))/100 * 100 : 0);
        if(iCount >= 100) {
            strStatus = 'Completed';
            bProcess = false;
        }
        else {
            strStatus = 'Processing => ' + iCount + '/100';
        }  
        
        iCount += 45;
        return null;
    }

    public static void updateTaskSequence(List<Task__c> newTaskList) {
        List<Process__c> updateProcessList = new List<Process__c>();
        List<Id> processIds = new List<Id>();
       
        for(Task__c taskObj : newTaskList) {
            processIds.add(taskObj.Process__c);
        }
       
        if(processIds.size() > 0) {
            Decimal count = 0;
            for(Process__c process : [SELECT Id, Name , (SELECT Id, Name, Task_Sequence__c, Contact__c, Status__c  FROM TaskChild__r LIMIT 50000) FROM Process__c WHERE Id IN : processIds LIMIT 50000]) {
                count = process.TaskChild__r.size();
                for(Task__c task : newTaskList) {
                    if(process.Id == task.Process__c) {
                        task.Task_Sequence__c = count + 1;
                        if(task.Contact__c != null && task.Status__c == 'Draft') {
                            task.Status__c = 'Assigned';
                            process.Status__c = 'In Progress';
                            process.Start_Date__c = system.today();
                            updateProcessList.add(process);
                        } else if(task.Contact__c == null && (task.Status__c == 'Assigned' || task.Status__c == 'In Progress' || task.Status__c == 'Completed')) {
                            task.addError('Please First assigned the contact', false);
                        } 
                        count++;
                    }
                }
            }
        }
        if(updateProcessList.size() > 0) {
            update updateProcessList;
        }   
    }
    
    public static void updateTask(List<Task__c> newTaskList) {
        List<Process__c> updateProcessList = new List<Process__c>();
        List<Id> processIds = new List<Id>();
        List<Task__c> taskList = new List<Task__c>();
        
       
        List<Id> taskIds = new List<Id>();
        for(Task__c taskObj : newTaskList) {
            processIds.add(taskObj.Process__c);
            taskIds.add(taskObj.Id);
        }
        
        if(processIds.size() > 0) {
            Date startDate  = [SELECT Id, Name, Task_Sequence__c, Status__c,Start_Date__c FROM Task__c WHERE Task_Sequence__c = 1 AND Process__c IN : processIds LIMIT 1].Start_Date__c;
            Decimal count = 0;
             for(Process__c process : [SELECT Id, Name , (SELECT Id, Name, Task_Sequence__c, Contact__c, Status__c, Start_Date__c, End_Date__c FROM TaskChild__r LIMIT 50000) FROM Process__c WHERE Id IN : processIds LIMIT 50000]) {
                count = process.TaskChild__r.size();
                for(Task__c task : newTaskList) {
                    if(process.Id == task.Process__c) { 
                        if(task.Task_Sequence__c == 1) {
                            if(task.Contact__c != null && task.Status__c =='Draft'){
                                task.Status__c = 'Assigned';
                                process.Status__c = 'In Progress';
                                process.Start_Date__c = system.today();
                                updateProcessList.add(process);
                            }
                            if(task.Status__c == 'In Progress' && task.Contact__c != null) {
                                task.Start_Date__c = system.today();
                            }
                            else if(task.Status__c == 'Completed' && task.Contact__c != null) {	
                                task.End_Date__c = system.today();
                            }
                        }else {
                            cheackStatusBySequence(task.Task_Sequence__c, task.Process__c, newTaskList);
                        }

                        if(task.Task_Sequence__c == count && task.Status__c == 'Completed' && task.Contact__c != null){
                            process.Status__c = 'Completed';
                            process.End_Date__c = system.today();
                            process.Days_to_Complete__c = startDate.daysBetween(task.End_Date__c);
                            updateProcessList.add(process);
                        } 
                    }
                    taskList.add(task);    
                }   
            }
            if(updateProcessList.size() > 0) {
                update updateProcessList;
            }   
        }
    }


    public static void cheackStatusBySequence(Decimal taskStatus, String processId, List<Task__c> newTaskList) {
        taskStatus--;
        List<Task__c> taskList = [SELECT Id, Name, Task_Sequence__c, Status__c FROM Task__c WHERE Task_Sequence__c =: taskStatus AND Process__c =: processId LIMIT 50000];
        if (taskList[0].Status__c == 'Completed') {
            for(Task__c task : newTaskList) { 
                if(task.Contact__c != null && task.Status__c =='Draft'){
                    task.Status__c = 'Assigned';
                }
                if(task.Status__c == 'In Progress' && task.Contact__c != null) {	
                    task.Start_Date__c = system.today();
                }
                else if(task.Status__c == 'Completed' && task.Contact__c != null) {	
                    task.End_Date__c = system.today();
                }
            }
        } else {
            Trigger.new[0].addError('Please Completed Previous task', false);
        }

    }
    
}