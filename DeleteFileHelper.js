({
	doInit : function(cmp, event, helper) {
		cmp.set('v.columns', [
            {label: 'File Name', fieldName: 'title', type: 'text'},
            {label: 'File Type', fieldName: 'fileType', type: 'text'},
            {label: 'Action', type: 'button',  typeAttributes: { label: 'Delete', name: 'delete', title: 'Delete'}},
        ]);	
        var action = cmp.get('c.getFiles');
        action.setParams({
            "objectId" : cmp.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.data", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);    
	}
})