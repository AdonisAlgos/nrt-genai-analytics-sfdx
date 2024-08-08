public with sharing class ConferenceHandler {
    public static void insertTranscript(Id conferenceId, String transcript) {
        if (!hasCRUDPermissions()) {
            throw new SecurityException('Insufficient permissions to update the conference transcript.');
        }
        
        // Update the conference transcript
        Conference__c conference = [SELECT Id, Transcript__c FROM Conference__c WHERE Id = :conferenceId];
        conference.Transcript__c = transcript;
        update conference;

    }

    private static Boolean hasCRUDPermissions() {
        return Schema.sObjectType.Conference__c.isAccessible() && Schema.sObjectType.Conference__c.fields.Transcript__c.isUpdateable();
    }
}