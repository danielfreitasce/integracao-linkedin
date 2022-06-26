public with sharing class CalloutConfigSelector implements ICalloutConfigSelector
{
    public static Callout_Config__c getCalloutConfigByName(String calloutConfigName)
    {
        Callout_Config__c calloutConfig = [SELECT Nome_do_Servico__c, Client_Id__c, Client_Secret__c, Callback_Url__c, Endpoint__c, Method_Name__c
        FROM Callout_Config__c
        WHERE Nome_do_Servico__c =: calloutConfigName]; 

        return calloutConfig; 
    }
}
