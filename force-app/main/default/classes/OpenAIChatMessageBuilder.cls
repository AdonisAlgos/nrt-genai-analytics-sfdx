/**
 * @description       : Class to build messages for OpenAI API
 * @author            : adonisgeorgiou@hotmail.co.uk
 * @created date      : 09-08-2024
 * @last modified on  : 
 * @last modified by  : adonisgeorgiou@hotmail.co.uk
**/
public with sharing class OpenAIChatMessageBuilder {
    private Map<String,String> systemPrompt;
    private Map<String,String> assistantPrompt;
    private Map<String,String> userPrompt;

    /**
    * @description constructor builds maps of prompts
    * @param Map<String,String> reqSettings
    * @param Session__c session
    */
    public OpenAIChatMessageBuilder(Map<String, String> reqSettings, Conference__c conference) {
        
        String transcript = conference.Transcript__c ?? '';

        this.systemPrompt = new Map<String,String>{
            Constants.ROLE => 'system',
            Constants.CONTENT => reqSettings.get(Constants.System_Prompt) ?? ''
        };

        this.assistantPrompt = new Map<String,String>{
            Constants.ROLE => 'assistant',
            Constants.CONTENT => reqSettings.get(Constants.Assistant_Prompt) ?? ''
        };

        this.userPrompt = new Map<String,String>{
            Constants.ROLE => 'user',
            Constants.CONTENT => (reqSettings.get(Constants.User_Prompt) ?? '') + transcript
        };
    }

    /**
    * @description build Open AI chat messages
    * @return JSON messages separated by comma
    */
    public String buildChatMessages() {
        String chatMessages = JSON.serialize(this.systemPrompt) + ', ' + 
                            //   JSON.serialize(this.assistantPrompt) + ', ' +
                              JSON.serialize(this.userPrompt);

        return chatMessages.replace('\\r', '').replace('\\n', '');
    }
}