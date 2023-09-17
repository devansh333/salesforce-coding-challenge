public with sharing class SendOrderToNPSAPIService {
    public static String sendOrderForEmails(Id orderId){
        List<Id> orderIds = new List<Id>();
        orderIds.add(orderId);
    
        Map<Id, Order> orderMap = RecordSelectorUtility.selectOrders(orderIds); 
                
        List<OrderRecord> orderRecords = new List<OrderRecord>();
    
        for(Order ord: orderMap.values()){
                    OrderRecord record = new OrderRecord();
                    record.sfId = ord.Id;
                    record.orderNumber = ord.OrderNumber;
                    record.customerEmail = ord.BillToContact.Email;
                    orderRecords.add(record);
        }
    
        String endpoint = 'callout:NPSNamedCredential/orders';
        String method = 'POST';
        String requestBody=JSON.serialize(orderRecords);
    
        system.debug('requestBody '+requestBody);
        
        HttpResponse response = HttpCalloutUtility.sendHttpRequest(endpoint, method, requestBody);
        String responseBody = response.getBody();
        return responseBody;
    }
    
    public class OrderRecord {
        public String sfId { get; set; }
        public String orderNumber { get; set; }
        public String customerEmail { get; set; }
    }
}