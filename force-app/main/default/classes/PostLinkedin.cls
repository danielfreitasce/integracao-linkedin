public class PostLinkedin {
    
    @AuraEnabled
    public static void enviarPublicacao(String jsonString)
    {
        String auth = 'AQUj-xARs_I43C0ZoGJNZeqpeiOLfMb7mq05DqEx7iNCoX5YDKdqj0Ktf6JTebQZL6J7T8Zi4DFwWyVW5ORneQiFzermuMGI7J-u214bT0Ur9ufnv_xF4D8YuoAngbx38DCpxu1lGOjXdD-JAnxjj2GtizCodOR9TGPwGgyyTl1twI76S4ZNQsK26_00d-iW6bIQRBS6NXSR4U3ORRZTP4hCqduQef8ob8lCLIXdLCEiMrU_39bj_IKv1V0k3TvwDTFas7v12tgx4JdhQXHM80D47jC4AnnzvsDuyu0q6C3OzWlyGndN0vcKbGXaHXxGNTH9JvuVR-S5WJWsrNYft0HZWI-Riw';
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.linkedin.com/v2/ugcPosts');
        req.setHeader('X-Restli-Protocol-Version', '2.0.0');
        req.setHeader('Content-type', 'aplication/json');
        req.setHeader('Authorization', 'Bearer '+auth);
        req.setBody(jsonString);
        
        Http binding = new Http();
        HttpResponse res = binding.send(req);
        System.debug('res code status ' + res.getStatusCode());
        System.debug('res body' + res.getBody());
        
    }
}