public with sharing class PythonAnywhereIntegration {
    @AuraEnabled
    public static void sendDataToPythonAnywhere(String fileUrl, String conferenceId) {
        try {
            // Set up the HTTP request
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://your-pythonanywhere-username.pythonanywhere.com/your-endpoint');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            // Construct the payload
            Map<String, String> payload = new Map<String, String>();
            payload.put('file_url', fileUrl);
            payload.put('conference_id', conferenceId);
            
            // Convert the payload to JSON
            String jsonBody = JSON.serialize(payload);
            req.setBody(jsonBody);
            
            // Send the request
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            // Log the response
            System.debug('Response from PythonAnywhere: ' + res.getBody());
        } catch (Exception e) {
            System.debug('Error sending data to PythonAnywhere: ' + e.getMessage());
        }
    }
}
