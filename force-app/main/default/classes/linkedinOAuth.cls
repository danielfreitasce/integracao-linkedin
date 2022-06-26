global class linkedinOAuth {

  public Map<String, String> retorno{get;set;}
  //ao instanciar a página, pego os parametros do retorno. 
  global linkedinOAuth(){
      
        retorno =  ApexPages.currentPage().getParameters();
  }
      
  //insiro os parametros do retorno no objeto
  public void  registerCode() {
  String authorization_code = (String) retorno.get('code'); 
  String state = (String) retorno.get('state');
  String userId = state.substring(8,26);

  if(String.isBlank(userId)) return; 


  Linkedin_User_Config__c userConfig = [SELECT Id, User_Id__c, User_Id__r.Name, State__c, urn_li_person__c, Access_Token__c, Access_Token__r.Token__c, Access_Token__r.Expires_In__c
  FROM Linkedin_User_Config__c 
  WHERE User_Id__c =: userId
  ];


  if(userConfig.State__c != state){
    System.debug('houve um errro na comunicacao e o state não foi encontrato');
    return; 
  }
  
  // Callout_Config__c calloutConfig =  callountConfigSelectorInstance.getCalloutConfigByName('LinkedinOAuth'); 
  Callout_Config__c calloutConfig = [SELECT Nome_do_Servico__c, Client_Id__c, Client_Secret__c, Callback_Url__c, Endpoint__c, Method_Name__c
        FROM Callout_Config__c
        WHERE Nome_do_Servico__c = 'LinkedinOAuth']; 

  String reqbody = 'grant_type=authorization_code&code='+authorization_code+'&redirect_uri='+calloutConfig.Callback_Url__c+'&client_id='+calloutConfig.Client_Id__c+'&client_secret='+calloutConfig.Client_Secret__c;
      
  HttpRequest req = new HttpRequest();
  req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
  req.setMethod(calloutConfig.Method_Name__c);
  req.setEndpoint(calloutConfig.Endpoint__c);
  req.setBody(reqbody);

  Http binding = new Http();
  HttpResponse res = binding.send(req);
    
  Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody()); 
  System.debug('results' + results);

  String error = (String)results.get('error');
  String accessToken = (String) results.get('access_token'); 
  Decimal expiresIn = (Decimal) results.get('expires_in');
  
  if(!String.isBlank(error)) return; 
  
  if(String.isBlank(userConfig.Access_Token__c))
  {
      Access_Token__c accesToken = new Access_Token__c(
        Name = userConfig.User_Id__r.Name + ' Token',
        Token__c = accessToken, 
        Expires_In__c =  expiresIn
      );
    
    insert accesToken; 
    userConfig.Access_Token__c = accesToken.Id;
  }
  else
  {
     userConfig.Access_Token__r.Token__c = accessToken;
     userConfig.Access_Token__r.Expires_In__c =  expiresIn;
  }

  update userConfig; 
 
  }
  
 
}