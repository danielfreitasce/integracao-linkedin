public class PostLinkedin {
    
    @AuraEnabled
    public static void enviarPublicacao(String jsonString)
    {
        LinkedinCodeAuth__c token = [SELECT OAuth__c FROM LinkedinCodeAuth__c WHERE State__c = '@lieBe347590876453738342'];
        System.debug(token);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.linkedin.com/v2/ugcPosts');
        req.setHeader('X-Restli-Protocol-Version', '2.0.0');
        req.setHeader('Content-type', 'aplication/json');
        req.setHeader('Authorization', 'Bearer '+token.OAuth__c);
        req.setBody(jsonString);
        
        Http binding = new Http();
        HttpResponse res = binding.send(req);
        System.debug('res code status ' + res.getStatusCode());
        System.debug('res body' + res.getBody());
        
    }
}