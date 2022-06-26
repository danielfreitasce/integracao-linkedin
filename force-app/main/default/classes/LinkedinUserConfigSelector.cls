public with sharing class LinkedinUserConfigSelector implements ILinkedinUserConfigSelector
{
    public LinkedinUserConfigSelector() {

    }

    public static Linkedin_User_Config__c getUserConfigWhithoutToken(Id userId)
    {
        for(Linkedin_User_Config__c userConfig :[SELECT Name, User_Id__c, State__c, urn_li_person__c, Access_Token__c, Access_Token__r.Expira_em__c
                                  FROM Linkedin_User_Config__c 
                                  WHERE User_Id__c =: userId
                                ])
        {
            return userConfig; 
        }

        return null;
    }

    public static Linkedin_User_Config__c getUserConfigWhithToken(Id userId)
    {
        for(Linkedin_User_Config__c userConfig : [SELECT Id, User_Id__c, User_Id__r.Name, State__c, urn_li_person__c, Access_Token__c, Access_Token__r.Token__c, Access_Token__r.Expires_In__c
        FROM Linkedin_User_Config__c 
        WHERE User_Id__c =: userId
        ])
        {
            return userConfig; 
        }

        return null;
    }

}
