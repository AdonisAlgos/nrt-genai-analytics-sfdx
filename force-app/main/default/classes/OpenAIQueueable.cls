public with sharing class OpenAIQueueable implements Queueable, Database.AllowsCallouts {

    private Map<String, String> reqSettings;
    private Conference__c conference;

    // Constructor to pass the necessary parameters
    public OpenAIQueueable(Map<String, String> reqSettings, Conference__c conference) {
        this.reqSettings = reqSettings;
        this.conference = conference;
    }

    // The execute method where the HTTP callout will be made
    public void execute(QueueableContext context) {
        try {
            // Make the HTTP request to OpenAI API
            HttpResponse response = OpenAIConnect.makeChatRequest(reqSettings, conference);

            // Handle the response (this is just a placeholder)
            if (response.getStatusCode() == 200) {
                System.debug('OpenAI response: ' + response.getBody());
                // You can add logic to update the conference record with the response here if necessary
            } else {
                System.debug('OpenAI request failed with status code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Failed to make OpenAI callout: ' + e.getMessage());
        }
    }
}

