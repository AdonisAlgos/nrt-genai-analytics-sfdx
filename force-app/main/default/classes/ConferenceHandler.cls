/**
 * @description       : Conference object record handler
 * @author            : adonisgeorgiou@hotmail.co.uk
 * @created date      : 09-08-2024
 * @last modified on  : 
 * @last modified by  : adonisgeorgiou@hotmail.co.uk
**/

public with sharing class ConferenceHandler {
    public static void updateTranscript(Id conferenceId, String transcript) {
        // Update the conference transcript
        Conference__c conference = [SELECT Id, Transcript__c FROM Conference__c WHERE Id = :conferenceId LIMIT 1];
        conference.Transcript__c = transcript;
        update conference;
    }

    public static void createConferenceRecord(String transcription) {
        Conference__c newConference = new Conference__c();
        newConference.Name = 'Transcribed Conference';
        newConference.Transcript__c = transcription;
        insert newConference;
    }
}