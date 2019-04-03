@isTest
public with sharing class TestEmployeeCompensationsController {
    
    @isTest
    public static void TestGetCompensations() {
        TestEmployeeCompensationsController.TestDataFactory();
        Test.startTest();
        List<Compensation__c> compensations =  EmployeeCompensationsController.getCompensations();
        Test.stopTest();
        System.assert(compensations.size() >= 10);
    }

    @isTest
    public static void TestGetCompensationsWithEmployeeId(){
        List<Compensation__c> comps = TestEmployeeCompensationsController.TestDataFactory();
        Test.startTest();
        List<Compensation__c> compensations =  EmployeeCompensationsController.getMyCompensations(comps.get(0).Employee__c);
        Test.stopTest();
        System.assert(compensations.size()==10);
    }

    @isTest
    public static void TestNoAccessCompensations(){
        List<Compensation__c> comps = TestEmployeeCompensationsController.TestDataFactory();
        User u = TestEmployeeCompensationsController.getNoAccessUser();
        try{
            System.runAs(u){
                List<Compensation__c> compensations =  EmployeeCompensationsController.getCompensations();
            }
        }
        catch(NoAccessException e){

        }
        
    }


    @isTest
    public static void TestNoAccessMyCompensations(){
        List<Compensation__c> comps = TestEmployeeCompensationsController.TestDataFactory();
        User u = TestEmployeeCompensationsController.getNoAccessUser();
        try{
            System.runAs(u){
                List<Compensation__c> compensations =  EmployeeCompensationsController.getMyCompensations(comps.get(0).Employee__c);
            }
        }
        catch(NoAccessException e){

        }
        
    }

    public static List<Compensation__c> TestDataFactory(){
        List<Compensation__c> comps = new List<Compensation__c>();
        Contact employee = new Contact(LastName='Smith');
        insert employee;
        for(Integer i=0; i<10; i++){
            comps.add(new Compensation__c(Name='Comp' + i, Location__c='India', Employee__c=employee.Id, Job_Category__c='Senior'));
        }
        insert comps;
        return comps;
    }

    public static User getNoAccessUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'stand', Email='standarduser@onboarding.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@onboarding.com');
        return u;

    }

}