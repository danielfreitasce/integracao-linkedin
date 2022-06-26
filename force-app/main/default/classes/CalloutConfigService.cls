public with sharing class CalloutConfigService
{
    @AuraEnabled(cacheable=true)
    public static List<String> getLinkedinAuthUrl(Id userId)
    {
        try {
        List<String> result = new List<String>();

        Callout_Config__c calloutConfig = instanciaCallountConfigSelector.getCalloutConfigByName('LinkedinCode'); 
        
        String state = EncodingUtil.convertToHex(Crypto.generateAesKey(128)).substring(0, 8) + userId;
        String callBackUrl = (String) calloutConfig.Callback_Url__c;
        String callBackUrlEncoded = EncodingUtil.urlEncode(callBackUrl, 'UTF-8');

        String url = calloutConfig.Endpoint__c +'?response_type=code&client_id='+calloutConfig.Client_Id__c+'&redirect_uri='+callBackUrlEncoded+'&state='+state+'&scope=r_liteprofile%20r_emailaddress%20w_member_social'; 
 
        result.add(url); 
        result.add(state);
        return result; 

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static ICalloutConfigSelector instanciaCallountConfigSelector
    {
        get
        {
            if(instanciaCallountConfigSelector == null)
                instanciaCallountConfigSelector = (ICalloutConfigSelector) Type.forName('CalloutConfigSelector').newInstance();
            
            return instanciaCallountConfigSelector;
        }
        set;
    }
}
