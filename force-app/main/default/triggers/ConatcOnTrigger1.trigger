trigger ConatcOnTrigger1 on Contact (after insert,after delete,after undelete,after update) {
    HelperClassForSequenceNumber1  HelperClassObj = new HelperClassForSequenceNumber1();
    
    if(trigger.isInsert) {
      //   if(NewClassForContact.runWk()) {
             HelperClassObj.ForInsertRecordInSequenceField(Trigger.New);
        // }
    }
    
   if(trigger.isDelete) {
            HelperClassObj.ForDeleteRecordInSequenceField(Trigger.Old);
   }
  /*if(trigger.isUndelete) {
        HelperClassObj.ForInsertRecordInSequenceField(Trigger.New);
   }*/
  if(trigger.isUpdate) {
      list<Contact> conToUpdate = new list<Contact>();
      
      List<FeedItem> FeedItemList = New List<FeedItem>();

    for (Contact con : trigger.new) {

        FeedItem post = new FeedItem();

        post.ParentId = con.OwnerId;
        post.Body = 'caseitem.Message_To_Alert__c';
        post.Title = 'Case';
        post.LinkUrl = '/lightning/r/Contact/' + con.ID + '/view';
        FeedItemList.add(post);

    }

    if (FeedItemList.size()>0) {         
            insert FeedItemList;                
    }
      //HelperClassObj.updateContacts(conToUpdate);
   }

}
//Trigger.OldMap, Trigger.NewMap