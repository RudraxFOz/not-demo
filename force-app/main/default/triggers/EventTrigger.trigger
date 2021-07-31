trigger EventTrigger on Event__c (before insert, after insert) {
    if (Trigger.isInsert ) {
        CreateInvitation.createInvitationForContact(trigger.new);
    }

}