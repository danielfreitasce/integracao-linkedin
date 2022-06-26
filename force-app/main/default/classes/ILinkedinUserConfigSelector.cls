public interface ILinkedinUserConfigSelector
{
    Linkedin_User_Config__c getUserConfigWhithoutToken(Id userId);
    Linkedin_User_Config__c getUserConfigWhithToken(Id userId);
}
