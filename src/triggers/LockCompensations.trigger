trigger LockCompensations on Compensation__c (before update, before delete) {
    for(Compensation__c c : Trigger.old){
        if(c.Submitted__c == true){
            c.addError('Record cannot be updated or deleted');
        }
    }
}