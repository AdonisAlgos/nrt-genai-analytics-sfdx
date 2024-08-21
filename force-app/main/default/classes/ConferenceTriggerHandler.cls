public class ConferenceTriggerHandler {
    
    public static void processTranscriptUpdates(Map<Id, Conference__c> oldConferences, Map<Id, Conference__c> newConferences) {
        List<Conference__c> conferencesToUpdate = new List<Conference__c>();

        for (Id confId : newConferences.keySet()) {
            Conference__c newConf = newConferences.get(confId);
            Conference__c oldConf = oldConferences.get(confId);

            // Check if the Transcript field has been updated
            if (newConf.Transcript__c != oldConf.Transcript__c && newConf.Transcript__c != null) {

                // Add your logic to enqueue the OpenAI request
                System.debug('Transcript updated for Conference: ' + confId);

                // Assuming you already have the request settings in place
                Map<String, String> reqSettings = OpenAITranscriptAnalysisSelectors.getOpenAIRequestSettings(Constants.TRANSCRIPT_ANALYST);
                
                // Enqueue the job to process the OpenAI request asynchronously
                OpenAIQueueable queueableJob = new OpenAIQueueable(reqSettings, newConf);
                System.enqueueJob(queueableJob);

            }
        }
    }
}
