public with sharing class RecordSelectorUtility {
    public static Map<Id, Order> selectOrders(List<Id> orderIds) {
        return new Map<Id, Order>([SELECT Id, OrderNumber, BillToContact.Email FROM Order WHERE Id IN :orderIds WITH SECURITY_ENFORCED]);
    }
}