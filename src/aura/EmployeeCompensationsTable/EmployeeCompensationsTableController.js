({
    editRecord : function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId" : event.target.id
        });
        editRecordEvent.fire();
    },
    selectChange :function(component, event, handler) {
        var selectedRow = event.getSource().get("v.value");
        var selectEvent = component.getEvent("SelectCompensation");
        selectEvent.setParams({
            "compensationId" : component.get("v.compensation.Id"),
            "isChecked" : selectedRow
        })
        selectEvent.fire();
        
    }
})