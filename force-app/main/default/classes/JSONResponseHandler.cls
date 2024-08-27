public with sharing class JSONResponseHandler {

    public static void createJSONResponseRecord(String response, String conferenceName) {
        JSON_Response__c newJSONResponse = new JSON_Response__c();
        newJSONResponse.Name = conferenceName;
        newJSONResponse.JSON_Response__c = response;
        insert newJSONResponse;
    }
}