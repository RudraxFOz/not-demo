@isTest
global class AuthorizePaymentMockTest implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        //String YearAndMonth = selectYc + '-' + selectMc ;
        HttpResponse response = new HttpResponse();
         string messageBody ='{ "createTransactionRequest": { "merchantAuthentication": { "name": "8zQYF7f7r","transactionKey":"9nEp79YN59sxa2qW" }, '+
        '"refId": "123456", "transactionRequest": { "transactionType": "authOnlyTransaction", "amount": "5", "payment": { "creditCard": '+
        '{ "cardNumber":"52378348976456556","expirationDate":"2020-12","cardCode":"976" } }, "lineItems": { "lineItem": { "itemId": "1", '+
        '"name": "vase", "description": "Cannes logo", "quantity": "18", "unitPrice": "45.00" } }, "tax": { "amount": "4.26", "name": "level2 tax name",'+
        '"description": "level2 tax" }, "duty": { "amount": "8.55", "name": "duty name", "description": "duty description" }, "shipping": '+
        '{ "amount": "4.26", "name": "level2 tax name", "description": "level2 tax" }, "poNumber": "456654", "customer": { "id": "99999456654" },'+
        ' "billTo": { "firstName": "Ellen", "lastName": "Johnson", "company": "Souveniropolis", "address": "14 Main Street", "city": "Pecan Springs",'+
        ' "state": "TX", "zip": "44628", "country": "USA" }, "shipTo": { "firstName": "China", "lastName": "Bayles", "company": "Thyme for Tea", '+
        '"address": "12 Main Street", "city": "Pecan Springs", "state": "TX", "zip": "44628", "country": "USA" }, "customerIP": "192.168.1.1", '+
        '"transactionSettings": { "setting": { "settingName": "testRequest", "settingValue": "false" } }, "userFields": { "userField": [ '+
        '{ "name": "MerchantDefinedFieldName1", "value": "MerchantDefinedFieldValue1" }, { "name": "favorite_color", "value": "blue" } ] } } } }';
        //response.setHeader('Content-Type', 'application/json');
        response.setHeader('Content-length', String.valueOf(messageBody.length()));
        response.setBody('{"animal": {"id":2, "name":"Test"}}');
        //response.setStatusCode(200);
        return response; 
    }
}