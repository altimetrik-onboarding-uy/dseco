@isTest
public with sharing class TestTriggers {
    
    @isTest
    public static void TestLockCompensations() {
        String compId = TestTriggers.TestDataFactory();
        try{
            Database.DeleteResult result = Database.delete(compId);
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Record cannot be updated or deleted', result.getErrors()[0].getMessage());
        }
        catch(Exception e){

        }
        
    }

    @isTest
    public static void TestSubmitCompensation(){
        String compId = TestTriggers.TestDataFactory();
        Test.startTest();
        Compensation__c compensationToAssert = [SELECT Status__c FROM Compensation__c WHERE Id = :compId];
        Test.stopTest();
        System.assertEquals('Submitted', compensationToAssert.Status__c);
    }

    public static String TestDataFactory(){
        Contact c = new Contact(LastName='Smith');
        insert c;
        Compensation__c comp = new Compensation__c(Name='Comp', Location__c='India', Employee__c=c.Id, Job_Category__c='Senior', Submitted__c=true);
        insert comp;
        return comp.Id;
    }

}