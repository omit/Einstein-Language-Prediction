public class EinsteinLanguageAPI {
    private static String endPointUrl = 'https://api.einstein.ai/v2/language/';

    public static EinsteinLanguageResponse predict(String text, Boolean isIntent){
        return doPrediction(text, isIntent);
    }

    private static EinsteinLanguageResponse doPrediction(String text, Boolean isIntent){
        String accessKey = Label.Einstein_Access_Token;
        String modelId = Label.Einstein_Sentiment_Model_Id;  // sentiment;

        if(isIntent != null && isIntent){
            modelId = Label.Einstein_Intent_Model_Id; 
            endPointUrl += 'intent';
        }
        else{
             endPointUrl += 'sentiment';
        }
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('modelId', modelId);
        gen.writeStringField('document', text);
        gen.writeEndObject();
        String jsonBody =  gen.getAsString(); // { "modelId" : "CommunitySentiment", "document" : "Hello"}

        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('POST');
        httpReq.setEndpoint(endPointUrl);
        httpReq.setHeader('Authorization', 'Bearer ' + accessKey);
        httpReq.setHeader('Content-type', 'application/json');
        httpReq.setBody(jsonBody);
        EinsteinLanguageResponse objResp;
        try{
            HTTPResponse httpRes = http.send(httpReq);
            objResp = (EinsteinLanguageResponse) JSON.deserialize(httpRes.getBody(), EinsteinLanguageResponse.class);
        }
        catch(Exception ex){
            objResp = new EinsteinLanguageResponse();
            objResp.message = 'Error: ' + ex.getMessage();
        }
        return objResp;
    }
}