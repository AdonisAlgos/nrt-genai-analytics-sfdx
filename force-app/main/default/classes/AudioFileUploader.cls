public with sharing class AudioFileUploader {
    @AuraEnabled
    public static List<Id> createConference(String title, Id fileId) {
        List<Id> ids = new List<Id>();
        try {

        ContentVersion cv = [SELECT ContentDocumentId, Title, FileExtension, VersionData FROM ContentVersion WHERE ContentDocumentId = :fileId LIMIT 1];

        // Step 2: Create the Media__c record
        Media__c media = new Media__c();
        media.Name = cv.Title + '.' + cv.FileExtension;
        media.Media_URL__c = '/services/data/v61.0/sobjects/ContentVersion/' + cv.Id + '/VersionData';
        media.Content_Document_Id__c = cv.ContentDocumentId;
        media.Media_Type__c = cv.FileExtension;
        insert media;
        ids.add(media.Id);

        // Step 3: Create the Conference__c record and link it to the Media__c record
        Conference__c conference = new Conference__c();
        conference.Name = title;
        conference.Media_Reference__c = media.Id;
        insert conference;
        ids.add(conference.Id);

        // Step 4: Add ContentDocumentId to the result to send back to LWC
        ids.add(cv.ContentDocumentId);

        } catch (Exception e) {
            System.debug('An error occurred: ' + e.getMessage());
        }

        // Step 4: Return the ID of the newly created conference
        return ids;
    }
}

