@isTest
private class SendOrderToNPSAPIServiceTest {

    @isTest
    static void testSendOrderForEmails() {
        Account acct = TestDataUtility.createAccount();

        Contract ct = TestDataUtility.createContract(acct.Id);
        ct.Status = 'Activated';
        update ct;
        
        Contact testContact=TestDataUtility.createContact(); 
        
        Product2 pd = TestDataUtility.createProduct();
        
        Id standardPriceBookId = Test.getStandardPricebookId();
        
        PricebookEntry pbe = TestDataUtility.createPriceBookEntry(standardPriceBookId, pd.Id); 
        
        List<Order> testOrders = TestDataUtility.createOrder(acct.Id, ct.Id, testContact.id);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMockCalloutClass());
        String response = SendOrderToNPSAPIService.sendOrderForEmails(testOrders[0].Id);
        Test.stopTest();

        System.assertEquals('SUCCESS FAKE RESPONSE', response);

    }
}