public class DynamicKanbanViewController{
    @AuraEnabled(Cacheable = true)
    public static List<SObject> findRecords(String searchKey, String objectName,String searchField, String columns){
        if (searchKey != ''){
            String key = '%' + searchKey + '%';
            String QUERY = 'SELECT Id, ' + columns + ' FROM ' + objectName + 
                           ' WHERE ' + searchField + ' LIKE :key' + ' ORDER BY ' + searchField;
            List<SObject> sObjectList = Database.query(QUERY);
            return sObjectList;
        } else{
            return null;
        }
    }
}