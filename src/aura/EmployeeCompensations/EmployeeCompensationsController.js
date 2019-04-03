({
    onInit : function(component, event, helper) {
        helper.getData(component);
    },
    editRecord : function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId" : event.target.id
        });
        editRecordEvent.fire();
    },
    onChange : function(component, event, helper){
        var recordType = component.find("select").get("v.value");
        if(recordType === "All"){
            component.set("v.compensations", component.get("v.allCompensations"));
        }
        else {
            var allComps = component.get("v.allCompensations");
            var compsToShow = [];
            for( var i=0; i<allComps.length; i++){
                if(allComps[i].RecordType.Name === recordType){
                    compsToShow.push(allComps[i]);
                }
            }
            component.set("v.compensations", compsToShow);
        }
    }
})