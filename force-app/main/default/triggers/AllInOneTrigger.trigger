trigger AllInOneTrigger on AllInOne__c (before insert) {
		AllInOne__c[] all = Trigger.New;
    	HelperForAllInOne.countAllInOne(all);
}