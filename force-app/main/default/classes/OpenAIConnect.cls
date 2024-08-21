/**
 * @description       : Class to make requests to OpenAI API
 * @author            : adonisgeorgiou@hotmail.co.uk
 * @created date      : 20-08-2024
 * @last modified on  : 
 * @last modified by  : adonisgeorgiou@hotmail.co.uk
**/
public with sharing class OpenAIConnect {

    /**
    * @description makes a request to chat-complition API
    * @param reqSettings settings for request
    * @param Conference__c session with transcription text
    * @return HttpResponse
    */
    public static HttpResponse makeChatRequest(Map<String, String> reqSettings, Conference__c conference) {
        if (!hasPermission()) {
            throw new OpenAIConnectException(
                'You cannot access this feature as your user is missing the required permission set: ' + Constants.OPEN_AI_PERM_SET);
        }

        OpenAIChatMessageBuilder msgBuilder = new OpenAIChatMessageBuilder(reqSettings, conference);

        String modelName = reqSettings.get(Constants.Model_Name);
        
        String  reqBody = '{ "model": "'+modelName+'", "response_format":{"type": "json_object"}, "temperature":0, "max_tokens":1514, "top_p":1, "frequency_penalty":0, "presence_penalty":0, "messages": [ ';
        reqBody += msgBuilder.buildChatMessages();
        reqBody += ' ] }';

        System.debug('OpenAIConnect reqBody: ' + reqBody);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(Constants.METHOD_POST); 
        request.setEndpoint(reqSettings.get(Constants.Endpoint));
        request.setTimeout(Integer.valueOf(reqSettings.get(Constants.Timeout)));
        request.setbody(reqBody);

        HttpResponse response = http.send(request);

        System.debug('response: ' + response.toString() + '\n' + response.getBody());

        return response;
    }

    private static Boolean hasPermission() {
        Integer permSetCount = [
            SELECT COUNT()
            FROM PermissionSetAssignment
            WHERE AssigneeId = :UserInfo.getUserId() AND PermissionSet.Name = :Constants.OPEN_AI_PERM_SET];
        return permSetCount == 1;
    }

    /**
    * @description Inner class to throw an OpenAIConnect exception
    **/
    public class OpenAIConnectException extends Exception {}
}