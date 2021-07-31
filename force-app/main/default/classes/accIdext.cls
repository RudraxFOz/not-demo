public with sharing class accIdext {

public String accNum { get;set; }
public Contact cont { get;set; }

public accIdext(ApexPages.StandardController controller) {
    this.cont = (Contact)controller.getRecord();
}

public void retrieveAccName() {
    this.accNum = [SELECT AccountNumber FROM Account WHERE Id = :cont.AccountId].AccountNumber;
}
}