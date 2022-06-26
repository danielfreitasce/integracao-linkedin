public with sharing class LinkedinUserConfigService {
    public LinkedinUserConfigService() {

    }

    @AuraEnabled(cacheable=true)
    public static Boolean getLinkedinUserStatus(Id userId){

        Linkedin_User_Config__c userConfig = linkUserConfigSelectorInstance.getUserConfigWhithoutToken(userId); 
         
        if(userConfig == null)
        {
            return true; 
        }
        else 
        {
          if(String.isBlank(userConfig.Access_Token__c))
            return true;
          else if(userConfig.Access_Token__r.Expira_em__c == System.today())
            return true; 
        }

        return false;
     
    }

    @AuraEnabled
    public static Id insertUrlState(String state, Id userId)
    {
        Linkedin_User_Config__c userConfig = linkUserConfigSelectorInstance.getUserConfigWhithoutToken(userId); 
        if(userConfig == null)
        {
            Linkedin_User_Config__c userConfigSObj = new  Linkedin_User_Config__c(
                State__c = state,
                User_Id__c = userId
            ); 
            userConfig = userConfigSObj;
            insert userConfig;
        }else
        {
            userConfig.State__c = state;
            upsert userConfig;
        }
        
        return userConfig.Id; 
    }

    private static ILinkedinUserConfigSelector linkUserConfigSelectorInstance
    {
        get
        {
            if(linkUserConfigSelectorInstance == null)
                linkUserConfigSelectorInstance = (ILinkedinUserConfigSelector) Type.forName('LinkedinUserConfigSelector').newInstance();
            
            return linkUserConfigSelectorInstance;
        }
        set;
    }
}
