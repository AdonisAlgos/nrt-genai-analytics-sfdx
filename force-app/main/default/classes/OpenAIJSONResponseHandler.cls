public with sharing class OpenAIJSONResponseHandler {

    public static SpeakerInsights getContent(String jsonResponse) {
        JSONResponseWrapper wrapper = (JSONResponseWrapper) JSON.deserialize(jsonResponse,JSONResponseWrapper.class);
        SpeakerInsights insights = wrapper.speakerInsights;
        return insights;

    }

    public class SpeakerInsights {
        public Integer competence_satisfaction;
        public Integer relatedness_satisfaction;
        public Integer autonomy_satisfaction;
        public String overall_satisfaction;
        public String most_positive_sentence_competence;
        public String most_positive_sentence_relatedness;
        public String most_positive_sentence_autonomy;
        public String most_negative_sentence_competence;
        public String most_negative_sentence_relatedness;
        public String most_negative_sentence_autonomy;
        public Integer overall_conference_rating;
    }

    private class JSONResponseWrapper {
        public List<Choice> choices;
        public SpeakerInsights speakerInsights{
            get {
                return (SpeakerInsights) JSON.deserialize(
                    choices[0].message.content, SpeakerInsights.class);
            }
        }
    }

    private class Choice {
        public Message message;
    }

    private class Message {
        public String content;
    }

}