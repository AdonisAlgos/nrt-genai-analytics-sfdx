/**
 * @description       : OpenAI transcript analysis settings (reqSettings Map) setup
 * @author            : adonisgeorgiou@hotmail.co.uk
 * @created date      : 20-08-2024
 * @last modified on  : 
 * @last modified by  : adonisgeorgiou@hotmail.co.uk
**/

public with sharing class OpenAITranscriptAnalysisSelectors {

     private static Map<String, String> reqSettingsMap;

    /**
    * @description query OpenAI request settings and convert to map
    * @param String developerName of custom metadata record
    * @return Map<String, String> reqSettingsMap
    */

    public static Map<String, String> getOpenAIRequestSettings(String developerName) {
        if (reqSettingsMap != null) {
            return reqSettingsMap;
        }
        Open_AI_Request_Settings__mdt reqSettings = [
            SELECT
                Endpoint__c,
                Assistant_Prompt__c,
                System_Prompt__c,
                User_Prompt__c,
                Successful_Response_Status__c,
                Timeout__c,
                Model_Name__c
            FROM Open_AI_Request_Settings__mdt
            WHERE DeveloperName = :developerName
            LIMIT 1
        ];

        reqSettingsMap = convertReqSettingsToMap(reqSettings);
        return reqSettingsMap;
    }

    private static Map<String, String> convertReqSettingsToMap(Open_AI_Request_Settings__mdt reqSettings) {
        return new Map<String, String>{
            Constants.Endpoint => reqSettings.Endpoint__c,
            Constants.Assistant_Prompt => reqSettings.Assistant_Prompt__c,
            Constants.System_Prompt => reqSettings.System_Prompt__c,
            Constants.User_Prompt => reqSettings.User_Prompt__c,
            Constants.Successful_Response_Status => reqSettings.Successful_Response_Status__c,
            Constants.Timeout => String.valueOf(reqSettings.Timeout__c),
            Constants.Model_Name => reqSettings.Model_Name__c
        };
    }
}