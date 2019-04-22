global class BatchCompensationUpdate implements Database.Batchable<SObject>{

    global Integer recordsProcessed= 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        Date dateCreated = Date.today().addDays(-2);
        return Database.getQueryLocator('SELECT Id, Submitted__c FROM Compensation__c WHERE Submitted__c=false AND CreatedDate <= :dateCreated');
    }

    global void execute(Database.BatchableContext bc, List<Compensation__c> scope){
        for(Compensation__c comp : scope){
            comp.Submitted__c = true;
            recordsProcessed++;
        }
        update(scope);
    }

    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(recordsProcessed + ' records processed.');
        System.debug('Job finished with status: ' + job.Status + '. ' + job.NumberOfErrors + ' errors found.');
    }
}