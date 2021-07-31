trigger ChageAccount on Account (before insert) {
    for(Account a:Trigger.New) {
        if (a.industry=='Banking') {
            a.rating='Hot';
            a.Ownership='Public';
        }
    }
}