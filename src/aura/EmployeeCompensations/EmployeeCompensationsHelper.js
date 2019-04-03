({
    getData : function(component) {
        var isLoaded = component.get("v.dataIsLoaded");
        
            var action = component.get("c.getCompensations");
            action.setCallback(this, function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    var rows = response.getReturnValue();
                    if(!isLoaded){
                        component.set("v.compensations", rows);
                    }                    
                    component.set("v.allCompensations", rows);
                    console.log("Data loaded successfully.");
                }else if(state === "ERROR"){
                    console.log("An error occurred: " + response.getError());
                }
            });
            $A.enqueueAction(action);
    }
})