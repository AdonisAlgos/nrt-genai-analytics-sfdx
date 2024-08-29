public with sharing class ConferenceInsightHandler {

    public static void createConferenceInsights(OpenAIJSONResponseHandler.SpeakerInsights attendeeInsights, Id conferenceId, String conferenceName) {

        Conference_Insight__c insightRecord = new Conference_Insight__c();

        insightRecord.Competence_Satisfaction__c = attendeeInsights.competence_satisfaction;
        insightRecord.Relatedness_Satisfaction__c = attendeeInsights.relatedness_satisfaction;
        insightRecord.Autonomy_Satisfaction__c = attendeeInsights.autonomy_satisfaction;
        insightRecord.Overall_Satisfaction__c = attendeeInsights.overall_satisfaction;
        insightRecord.Most_Positive_Sentence_Competence__c = attendeeInsights.most_positive_sentence_competence;
        insightRecord.Most_Positive_Sentence_Relatedness__c = attendeeInsights.most_positive_sentence_relatedness;
        insightRecord.Most_Positive_Sentence_Autonomy__c = attendeeInsights.most_positive_sentence_autonomy;
        insightRecord.Most_Negative_Sentence_Competence__c = attendeeInsights.most_negative_sentence_competence;
        insightRecord.Most_Negative_Sentence_Relatedness__c = attendeeInsights.most_negative_sentence_relatedness;
        insightRecord.Most_Negative_Sentence_Autonomy__c = attendeeInsights.most_negative_sentence_autonomy;
        insightRecord.Overall_Conference_Rating__c = attendeeInsights.overall_conference_rating;
        insightRecord.Conference__c = conferenceId;
        insightRecord.Name = conferenceName +' Attendee';

        insert insightRecord;

    }
}