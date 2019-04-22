@isTest
public with sharing class TestScheduleBatch {

    @isTest
    public static void TestScheduledBatch() {
        List<Compensation__c> comps = new List<Compensation__c>();
        Contact employee = new Contact(LastName='Smith');
        insert employee;
        for(Integer i=0; i<100; i++){
            comps.add(new Compensation__c(Name='Comp' + i, Location__c='India', Employee__c=employee.Id, Job_Category__c='Senior'));
        }
        insert comps;
        List<String> compIds = new List<String>();
        for(Compensation__c c : comps){
            compIds.add(c.Id);
            Test.setCreatedDate(c.Id, Date.today().addDays(-2));
        }
        Test.startTest();
        SubmitCompensationsScheduler scs = new SubmitCompensationsScheduler();
        String jobId = System.schedule('myJobTestJobName', '0 0 0 1 1 ?', scs);
        scs.execute(null);
        // BatchCompensationUpdate bcu = new BatchCompensationUpdate();
        // Database.executeBatch(bcu);
        Test.stopTest();
        Integer count = 0;
        List<Compensation__c> updatedComps = [SELECT Id, Submitted__c FROM Compensation__c WHERE Id IN :compIds];
        for(Compensation__c c : updatedComps){
            if(c.Submitted__c == false){
                count++;
            }
        }
        System.assertEquals(0, count);
    }



}