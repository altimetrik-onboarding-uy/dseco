public with sharing class EmployeeCompensationsController {


    private static Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SobjectType.Compensation__c.fields.getMap();

        @AuraEnabled
        public static List<Compensation__c> getCompensations(){
            
            String[] fieldsToCheck = new String[]{
                'Id', 'Name','RecordTypeId', 'Employee__c', 'Job_Category__c', 'Amount__c', 'Location__c',
                'Office__c', 'Submitted__c', 'Status__c'
            };

            //Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SobjectType.Compensation__c.fields.getMap();

            for(String field : fieldsToCheck){
                if(!EmployeeCompensationsController.fieldDescribeTokens.get(field).getDescribe().isAccessible()){
                    throw new System.NoAccessException();
                }
            }

            return [SELECT Id, Name, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Job_Category__c, Amount__c, Location__c,
                    Office__c, Submitted__c, Status__c FROM Compensation__c];

        }


        @AuraEnabled
        public static List<Compensation__c> getMyCompensations(String Id){



            String[] fieldsToCheck = new String[]{
                'Id', 'Name', 'RecordTypeId', 'Employee__c', 'Job_Category__c', 'Amount__c', 'Location__c',
                'Office__c', 'Submitted__c', 'Status__c'
            };

            //Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SobjectType.Compensation__c.fields.getMap();

            for(String field : fieldsToCheck){
                if(!EmployeeCompensationsController.fieldDescribeTokens.get(field).getDescribe().isAccessible()){
                    throw new System.NoAccessException();
                }
            }

            return [SELECT Id, Name, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Job_Category__c, Amount__c, Location__c,
                    Office__c, Submitted__c, Status__c FROM Compensation__c WHERE Employee__r.Id = :Id];

        }

        @AuraEnabled
        public static void submitComps(String[] compsToSubmit){

            if(!EmployeeCompensationsController.fieldDescribeTokens.get('Submitted__c').getDescribe().isAccessible()){
                throw new System.NoAccessException();
            }

            List<Compensation__c> compsToUpdate = [SELECT Id, Submitted__c FROM Compensation__c WHERE Id IN :compsToSubmit];
            for(Compensation__c c : compsToUpdate){
                c.Submitted__c = true;
            }
            update(compsToUpdate);
        }

}