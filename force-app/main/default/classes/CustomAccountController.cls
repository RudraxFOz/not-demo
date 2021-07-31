public with sharing class CustomAccountController 
{

    public string AccountName {get;set;}

    public ApexPages.StandardSetController setCon 
    {
        get {
            if(setCon == null) 
            {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name FROM Account Order By Name asc]));
            }
            return setCon;
        }
        set;
    }

    public List<Account> getAccounts() 
    {
        return (List<Account>) setCon.getRecords();
    }

    public PageReference SaveRecord() 
    {
        Account newAccount = new Account();
        newAccount.Name = AccountName;
        insert newAccount;

        PageReference pageRefer = new PageReference('/apex/CustomAccountsPage');
        pageRefer.setRedirect(true);
        return pageRefer;
    }
}