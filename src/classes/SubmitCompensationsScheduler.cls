global class SubmitCompensationsScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchCompensationUpdate compUpdate = new BatchCompensationUpdate();
        Database.executeBatch(compUpdate);
    }
}