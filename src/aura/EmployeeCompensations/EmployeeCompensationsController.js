({
    onInit : function(component, event, helper) {
        helper.getData(component);
    },
    onChange : function(component, event, helper){
        var recordType = component.find("select").get("v.value");
        var submitted = component.find("selectSubmitted").get("v.value");
        helper.filterBy(component, recordType, submitted);
    },
    handleSelectedCompensation : function(component, event, helper) {
        var isChecked = event.getParam("isChecked");
        var compensationId = event.getParam("compensationId");
        var selectedList = component.get("v.selectedList");
        if(isChecked){
            selectedList.push(compensationId);
        }
        else{
            selectedList.splice(selectedList.indexOf(compensationId),1);
        }
        component.set("v.selectedList", selectedList);
    },
    submitSelectedCompensations : function(component, event, helper){
        helper.submitCompensations(component);
    },
    exportCsv : function(component, event, helper) {
        var dataToExport = component.get("v.compensations");
        var csv = helper.createCSV(component, dataToExport);
        if(csv == null){
            console.log("Nothing to export");
            return;
        }
        var hiddenElement = document.createElement("a");
        hiddenElement.href= "data:text/csv;charset=utf-8," + encodeURI(csv);
        hiddenElement.target= "_self";
        hiddenElement.download = "EmployeeCompensations.csv";
        document.body.appendChild(hiddenElement);
        hiddenElement.click();
    }
})