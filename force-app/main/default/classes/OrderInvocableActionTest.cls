@isTest
public class OrderInvocableActionTest {
    
    @TestSetup static void testData() {
		Account acct = TestDataUtility.createAccount();

        Contract ct = TestDataUtility.createContract(acct.Id);
        ct.Status = 'Activated';
        update ct;
        
        Contact testContact=TestDataUtility.createContact(); 
        
        Product2 pd = TestDataUtility.createProduct();
        
        Id standardPriceBookId = Test.getStandardPricebookId();
        
        PricebookEntry pbe = TestDataUtility.createPriceBookEntry(standardPriceBookId, pd.Id); 
        
        List<Order> testOrders = TestDataUtility.createOrder(acct.Id, ct.Id, testContact.id);
        
        Order oneOrder=TestDataUtility.createOrder(acct.Id, ct.Id);
	}
    
    @isTest
    static void testSendOrderToNPS() {   
        List<Order> testOrders = [Select Id, OrderNumber, BillToContact.Email from Order limit 10];
        Order oneOrder = [Select Id, OrderNumber, BillToContact.Email from Order where BillToContact.Email = null limit 1];
        
        List<OrderInvocableAction.Requests> requestList = new List<OrderInvocableAction.Requests>();
        OrderInvocableAction.Requests request1 = new OrderInvocableAction.Requests();
		request1.orderId = testOrders[0].Id;
        OrderInvocableAction.Requests request2 = new OrderInvocableAction.Requests();
		request2.orderId = testOrders[1].Id;
        OrderInvocableAction.Requests request3 = new OrderInvocableAction.Requests();
		request3.orderId = oneOrder.Id;
        requestList.add(request1);
        requestList.add(request2);
        requestList.add(request3);
		
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMockCalloutClass());
        List<OrderInvocableAction.Results> resultsList = OrderInvocableAction.sendOrderToNPS(requestList);
		Test.stopTest();
        
        System.assertEquals(3, resultsList.size());
        OrderInvocableAction.Results result = resultsList[0];
        System.debug('result.apiResponse '+result.apiResponse);
        System.assertNotEquals(null, result.apiResponse);
    }
}