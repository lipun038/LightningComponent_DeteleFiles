({
	doInit : function(cmp, event, helper) {
		helper.doInit(cmp, event, helper);	
	},
    handleRowAction : function(cmp, event, helper) {
    	var action = event.getParam('action');
        var row = event.getParam('row');
        if(action.name == 'delete'){
            console.log('---row.id : '+row.id);
            var action = cmp.get('c.deleteFiles');
            action.setParams({
                "objectId" : cmp.get("v.recordId"),
                "contentDocumentId" : row.id
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    helper.doInit(cmp, event, helper);	
                }
            });
            $A.enqueueAction(action); 
        }    
    }
})