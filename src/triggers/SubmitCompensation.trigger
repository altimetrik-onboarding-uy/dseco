trigger SubmitCompensation on Compensation__c (before insert, before update, before delete) {
    if(Trigger.old != null){
        for(Compensation__c c : Trigger.old){
            if(c.Submitted__c == true){
                c.addError('Record cannot be updated or deleted');
            }
        }
    }
    if(Trigger.new != null) {
        for(Compensation__c c : Trigger.new){
            if(c.Submitted__c == true){
                c.Status__c = 'Submitted';
            }
        }
    }
    
}