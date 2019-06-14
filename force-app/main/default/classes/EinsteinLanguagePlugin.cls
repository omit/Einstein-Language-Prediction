public class EinsteinLanguagePlugin {

    @InvocableMethod(label='Einstein Sentiment/Intent Prediction' description='Accept the text and return the sentiment or intent prediction result')
    public static List<FlowResponseParam> doAction(List<FlowRequestParam> lstRequest) {
        List<FlowResponseParam>  lstResp = new List<FlowResponseParam> ();
        if(lstRequest.size() > 0){
            FlowRequestParam flowReq = lstRequest[0];
            FlowResponseParam flowRes = new FlowResponseParam();
            flowRes.result = EinsteinLanguageAPI.predict(flowReq.sampleText, flowReq.isIntent).toString();
            lstResp.add(flowRes);
        }
        return lstResp;
    }

    public class FlowRequestParam {
        @InvocableVariable(required=true  label= 'Sample Text')
        public String sampleText;
        @InvocableVariable(label = 'Is Intent Prediction? (true for intent)' description= 'Pass the vale true if want to use text-intent prediction. If false or not specified then default type will be sentiment')
        public Boolean isIntent;
    }

    public class FlowResponseParam {
        @InvocableVariable()
        public String result;
    }
}