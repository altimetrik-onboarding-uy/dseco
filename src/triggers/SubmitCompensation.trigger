trigger SubmitCompensation on Compensation__c (before insert, before update) {
    for(Compensation__c c : Trigger.new){
        if(c.Submitted__c == true){
            c.Status__c = 'Submitted';
        }
    }
}