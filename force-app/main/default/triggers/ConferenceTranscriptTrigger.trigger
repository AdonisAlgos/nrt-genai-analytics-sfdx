trigger ConferenceTranscriptTrigger on Conference__c (after update) {
    // Delegate the logic to the handler class
    ConferenceTriggerHandler.processTranscriptUpdates(Trigger.oldMap, Trigger.newMap);
}

