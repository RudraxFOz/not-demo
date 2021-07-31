trigger invitationTrigger on Invitation__c (before insert, after insert) {
    if (Trigger.isInsert && Trigger.isAfter) {
        SendEmailForInvitation.CaseLegalmethod(trigger.new);
    }

}