public class UpdateRec {
    public void upRec() {
        List<Account> acc = [SELECT name,phone FROM Account];
        for(Account a:acc) {
            a.phone='34';
        }
        upsert acc;
    }
}