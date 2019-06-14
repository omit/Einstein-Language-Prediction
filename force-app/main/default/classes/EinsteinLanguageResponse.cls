public Class EinsteinLanguageResponse{
    
    public String message; // {"message":"Invalid access token"}

    public List<PredictResponse> probabilities;
    public class PredictResponse {
        public String label;
        public Double probability;
    }  

    /*

    {"probabilities":[{"label":"positive","probability":0.49664575},{"label":"negative","probability":0.28653383},{"label":"neutral","probability":0.2168204}],"object":"predictresponse"}

    */
    
    override public String toString() { 
        String result ='Einstein says, <br/>';
        if(probabilities != null){
            for(PredictResponse objProb : probabilities){
                result += objProb.label + ': ' + objProb.probability * 100 + '<br/>';
            }
        }
        else{
            result = message;
        }
        return result;
    }
}