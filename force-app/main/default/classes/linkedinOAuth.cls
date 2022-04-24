global class linkedinOAuth {
 
    public Map<String, String> retorno{get;set;}
    //ao instanciar a página, pego os parametros do retorno. 
     global linkedinOAuth(){
        
         retorno =  ApexPages.currentPage().getParameters();
    }
       
    //insiro os parametros do retorno no objeto
    public void  registerCode() {
 	  LinkedinCodeAuth__c newCode = new LinkedinCodeAuth__c (
            Code__c= (String) retorno.get('code'),
            State__c= (String) retorno.get('state')
          );
 
        insert newCode;
    }
   	
    
    
}