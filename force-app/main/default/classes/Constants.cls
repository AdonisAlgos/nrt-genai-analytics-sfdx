/**
 * @description       : Class with constants
 * @author            : adonisgeorgiou@hotmail.co.uk
 * @created date      : 09-08-2024
 * @last modified on  : 
 * @last modified by  : adonisgeorgiou@hotmail.co.uk
**/

public with sharing class Constants {
    public static final String OPEN_AI_PERM_SET = 'OpenAI_User';
    
    //Open_AI_Request_Settings__mdt fields
    public static final String ENDPOINT = 'Endpoint';
    public static final String ASSISTANT_PROMPT = 'Assistant_Prompt';
    public static final String SYSTEM_PROMPT = 'System_Prompt';
    public static final String USER_PROMPT = 'User_Prompt';
    public static final String Timeout = 'Timeout';
    public static final String SUCCESSFUL_RESPONSE_STATUS = 'Successful_Response_Status';
    public static final String MODEL_NAME = 'Model_Name';

    //Open_AI_Request_Settings__mdt record DeveloperNames
    public static final String TRANSCRIPT_ANALYST = 'TranscriptAnalyst';
    public static final String TRANSCRIPT_MONETIZATION = 'TranscriptMonetization';

    //Open_AI_Whisper_Request_Settings__mdt record DeveloperNames
    public static final String TRANSCRIPT_REQUEST = 'TranscriptRequest';

    //API methods
    public static final String METHOD_POST = 'POST';

    //OpenAI prompt properties
    public static final String ROLE = 'role';
    public static final String CONTENT = 'content';
}