@isTest
public class TestDataUtility {
    public static Account createAccount(){
        Account acct = new Account(Name='tAccount');
		insert acct;
        return acct;
    }
    
    public static Contact createContact(){
		Contact testContact= new Contact(
            FirstName = 'Test',
            LastName = 'Contact1',
            Email = 'testcontact1@email.com'
        );
		insert testContact;
		return testContact;        
    }
    
    public static Contract createContract(Id AccountId){
        Contract ct = new Contract();
        ct.AccountId = AccountId;
        ct.Status = 'Draft';
        ct.StartDate = Date.Today();
        ct.ContractTerm = 12;
        insert ct;
        return ct;
    }
    
    public static Product2 createProduct(){
        Product2 pd = new Product2(Name='Pord A',isActive=true);
        pd.IsActive = true;
        insert pd;
        return pd;
    }
	
    public static PricebookEntry createPriceBookEntry(Id priceBookId, Id productId){
        PricebookEntry pbe =new PricebookEntry(Pricebook2Id=priceBookId, Product2Id=productId, UnitPrice=99, isActive=true);
        insert pbe;
        return pbe;
    }
    
    public static Order createOrder(Id accountId, Id contractId){
        Order testOrder = new Order(
            Bill_Email_Sent__c = false,
			AccountId = accountId,
            EffectiveDate = Date.Today(),
			ContractId = contractId,
			Status = 'Draft'
        );
    	insert testOrder;
        return testOrder;
    }
    
    public static List<Order> createOrder(Id accountId, Id contractId, Id contactId){
        
        List<Order> testOrders = new List<Order>();
        for (Integer i = 0; i < 5; i++) {
            testOrders.add(new Order(
                BillToContactId = contactId,
            	Bill_Email_Sent__c = false,
				AccountId = accountId,
            	EffectiveDate = Date.Today(),
				ContractId = contractId,
				Status = 'Draft'
            ));
        }
        insert testOrders;
        return testOrders;
    }
}