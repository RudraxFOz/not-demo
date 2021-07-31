@isTest
public class CheckDuplicateOnLeadConvertHelperTest {

    static testmethod void test_trigger() {
            Lead leadRec1 = new Lead(FirstName = 'Namit', LastName = 'Jangid', Email ='Namit12jangid@gmail.com' , Phone = '457821455' , Company = 'BR', Status = 'Open - Not Contacted');
            Lead leadRec2 = new Lead(FirstName = 'Sonu', LastName = 'Sud', Email ='Sonu12sud@gmail.com' , Phone = '45782122455' ,Company = 'BR', Status = 'Open - Not Contacted');
            Lead leadRec3 = new Lead(FirstName = 'Namit', LastName = 'Kala', Email ='Namit12Kala@gmail.com' , Phone = '453421455' , Company = 'BR', Status = 'Open - Not Contacted');
            Lead leadRec4 = new Lead(FirstName = 'Namit', LastName = 'Kala', Email ='Namit12Kala@gmail.com' , Phone = '453421455' , Company = 'BR', Status = 'Open - Not Contacted');

            insert leadRec4;

            
            
            List<Lead> leadList = new List<Lead>();
            leadList.add(leadRec1);
            leadList.add(leadRec2);
            leadList.add(leadRec3);


             //Test.StartTest(); 
             

            DmlException expectedException;
            Test.startTest();
                try
                {
                    // perform operation

                    insert leadList;
                    CheckDuplicateOnLeadConvertHelper.checkDuplicateRecord(leadList);
                    List<Lead> oldList = [SELECT id,FirstName, LastName, email, Phone FROM lead];
                   

                    // leadRec4.FirstName = 'Sures';
                    // update leadRec4;
                    
                }
                catch (DmlException dmx)
                {
                    expectedException = dmx;
                }
            Test.stopTest();

            system.assertNotEquals(null, expectedException, 'You are inserting Duplicate lead');



            DmlException expectedException1;
                try
                {

                    leadRec4.FirstName = 'Sures';
                    update leadRec4;

                    CheckDuplicateOnLeadConvertHelper.checkDuplicateRecord(leadList);
                    
                }
                catch (DmlException dmx)
                {
                    expectedException1 = dmx;
                }

            system.assertNotEquals(null, expectedException1, 'You are inserting Duplicate lead'); 

			
		}

}