public with sharing class ProductHomeController1 {
    @AuraEnabled
	public static list<Product2> fetchParentRecords() {
		return [SELECT Id,Name FROM Product2 WHERE  RecordType.Name = 'Parent Product'];
	}

	@AuraEnabled
	public static list<Product_Attribute_Value__c> fetchChildRecords(String parentProductID) {
		if(String.isNotBlank(parentProductID)) {
			return [SELECT Product__c, Product_Attribute__r.Name, Value__c FROM Product_Attribute_Value__c WHERE Product__c IN ( SELECT Id FROM product2 WHERE Parent_Product__c  =: parentProductID )];
		}
		return null;
	}
}