public with sharing class OrderInvocableAction {
    @InvocableMethod(label='Invoke NPS API' description='Sends orders and corresponding contact emails to NPS API' callout=true)
    public static List<Results> sendOrderToNPS(List<Requests> requestList) {
            List<Results> responses = new List<Results>();
            for (Requests request : requestList) {
                Results result = new Results();
                try{
                    result.apiResponse=SendOrderToNPSAPIService.sendOrderForEmails(request.orderId);
                }
                catch(Exception ex){
                    result.ErrorMessage=ex.getMessage();
                }
                
                responses.add(result);
            }
            return responses;
    }   

    public class Requests {
        @InvocableVariable(label='Input Records' description='Order record Ids with fulfilled status' required=true)
        public Id orderId;
    }
    
    public class Results {
        @InvocableVariable(label='Output response' description='Response for each order' required=true)
        public String apiResponse;
        @InvocableVariable(label='Error Message' description='Error Message for operation' required=true)
        public String ErrorMessage;
    }
}