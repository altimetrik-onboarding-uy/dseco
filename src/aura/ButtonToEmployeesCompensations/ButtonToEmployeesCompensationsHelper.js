({
    fireEvent : function(component) {
        var action = component.get("c.getMyCompensations");
        action.setParams({
            "Id" : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var evt = $A.get("e.force:navigateToComponent");
                evt.setParams({
                    componentDef : "c:EmployeeCompensations",
                    componentAttributes: {
                        "compensations" : response.getReturnValue(),
                        "dataIsLoaded" : true
                    }
                });
                evt.fire();
            }
            else if(state=== "ERROR"){
                console.log("An error occurred: " + response.getErrors());
            }
        });
        $A.enqueueAction(action);
    }
})