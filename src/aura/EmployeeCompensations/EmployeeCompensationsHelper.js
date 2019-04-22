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
    },
    filterBy : function(component, recordType, submitted) {
        var allComps = component.get("v.allCompensations");
        var compsToShow = [];
        var isSubmitted;
        if(recordType === "All"){
            if(submitted === "Both"){
                compsToShow = allComps;
            }
            else{
                isSubmitted = JSON.parse(submitted);
                for( var i=0; i<allComps.length; i++){
                    if(allComps[i].Submitted__c === isSubmitted){
                        compsToShow.push(allComps[i]);
                    }
                }
            }
        }
        else{
            if(submitted === "Both"){
                for( var i=0; i<allComps.length; i++){
                    if(allComps[i].RecordType.Name === recordType){
                        compsToShow.push(allComps[i]);
                    }
                }
            }
            else {
                isSubmitted = JSON.parse(submitted);
                for( var i=0; i<allComps.length; i++){
                    if(allComps[i].RecordType.Name === recordType && allComps[i].Submitted__c === isSubmitted){
                        compsToShow.push(allComps[i]);
                    }
                }
            }
        }
        component.set("v.compensations", compsToShow);
    },
    submitCompensations : function(component) {
        var action = component.get("c.submitComps");
        action.setParams({
            "compsToSubmit" : component.get("v.selectedList")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.selectedList", []);
                $A.get('e.force:refreshView').fire();
            }
            else{
                console.log("An error occurred.");
            }
        });
        $A.enqueueAction(action);
    },
    createCSV : function(component, valuesToConvert) {
        if(valuesToConvert.length == 0){
            return null;
        }
        var csvResult="";
        for(var i=0;i<valuesToConvert.length;i++){
            csvResult+= valuesToConvert[i].Employee__r.Name + ',' + valuesToConvert[i].Employee__r.Birthdate + ',' + valuesToConvert[i].Job_Category__c + ',' + valuesToConvert[i].RecordType.Name +
            ',' + valuesToConvert[i].Amount__c + ',' + valuesToConvert[i].Location__c + ',' + valuesToConvert[i].Office__c + ',' + valuesToConvert[i].Submitted__c + ',' + valuesToConvert[i].Status__c + '\n';
        }
        return csvResult;
    }
})