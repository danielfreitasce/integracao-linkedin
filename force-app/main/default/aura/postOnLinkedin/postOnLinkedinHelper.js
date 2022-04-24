({
    sendPost : function(component) {
        let corpoPublicacao = component.get("v.body");         
        var action = component.get('c.enviarPublicacao');
        
        let requisicao = {
            "author": "urn:li:person:6OR_PUVayG",
            "lifecycleState": "PUBLISHED",
            "specificContent": {
                "com.linkedin.ugc.ShareContent": {
                    "shareCommentary": {
                        "text": corpoPublicacao
                    },
                    "shareMediaCategory": "NONE"
                }
            },
            "visibility": {
                "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"
            }
        }
        
        action.setParams({
            
            jsonString: JSON.stringify( requisicao )
            
        });
        
        
        action.setCallback(this, function(response) {
            var state=response.getState();
            var res =response.getReturnValue();
            if(state==="SUCCESS")
            {
 				let type = 'success';
                let title = "Sucesso!"; 
                let message = "Publicado com sucesso!";
                this.showToast(type, title, message, 0);
            }
            
        });
        $A.enqueueAction(action);
    },
    
     showToast: function (type, title, message, duration) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type,
            title,
            message,
            duration
        });
       toastEvent.fire();
      
    },
})