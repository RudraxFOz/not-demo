public class PagingDemoWithAlpabets 
{

	public List<String> SerchAlpabet{get;set;}
	public String SearchVar{get;set;}
	public list<Account> con{set;get;}
	public list<Account> ShowCon{set;get;}
	public integer sizee{get;set;}

	public PagingDemoWithAlpabets() 
	{ 
		SerchAlpabet=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
		con=new List<Account>();
		con=[SELECT Name,Phone,Active__c from Account order by Name];
		SearchVar='All';
		ShowCon=new List<Account>();
		for(Account c:con)
		{
			if(SearchVar.equals('All'))
				ShowCon.add(c);
			else 
				if(c.Name.startsWith(SearchVar.toLowerCase())||c.Name.startsWith(SearchVar))
				ShowCon.add(c);
		}
		sizee=ShowCon.size(); 
		
	}

	public PageReference display() 
	{
		system.debug('___________________SearchVar_______________________________'+SearchVar);
		ShowCon.clear();
		for(Account c:con)
		{
			if(SearchVar.equals('All'))
				ShowCon.add(c);
			else
				if(c.Name.startsWith(SearchVar.toLowerCase())||c.Name.startsWith(SearchVar))
				{
				   ShowCon.add(c);
				   system.debug('_______________if ______C__________________'+c);
				}   
		   
		}
		sizee=ShowCon.size(); 
		return null;
	}
}