@isTest
global class TestAccountProcessor {
    
    @isTest static void test_method_one() {
      
       
        List<AbandonedWrap> abandonedForInsert = new List<AbandonedWrap>();
        
        AbandonedWrap q = new AbandonedWrap();
        q.PhoneNo = '1234567890';
        q.ServiceId = '56';
        abandonedForInsert.add(q);
        system.debug(JSON.serialize(abandonedForInsert));
     
    }
    
    
    global class AbandonedWrap{
        public String PhoneNo;
        public String ServiceId;
        
    }
}