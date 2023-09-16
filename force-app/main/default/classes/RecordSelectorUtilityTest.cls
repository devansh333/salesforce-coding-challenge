@isTest
public class RecordSelectorUtilityTest {
	@isTest
    static void testSelectOrders() {
		Account acct = TestDataUtility.createAccount();

        Contract ct = TestDataUtility.createContract(acct.Id);
        ct.Status = 'Activated';
        update ct;
        
        Contact testContact=TestDataUtility.createContact(); 
        
        Product2 pd = TestDataUtility.createProduct();
        
        Id standardPriceBookId = Test.getStandardPricebookId();
        
        PricebookEntry pbe = TestDataUtility.createPriceBookEntry(standardPriceBookId, pd.Id); 
        
        List<Order> testOrders = TestDataUtility.createOrder(acct.Id, ct.Id, testContact.id);
        
        List<Id> orderIds= new List<Id>();
        for(Order ord: testOrders){
            orderIds.add(ord.Id);
        }

        Test.startTest();
        Map<Id, Order> result = RecordSelectorUtility.selectOrders(orderIds);
        Test.stopTest();
		
        for (Order testOrder : testOrders) {
            Order retrievedOrder = result.get(testOrder.Id);
            System.assertNotEquals(null, retrievedOrder);
        }
    }
 
}