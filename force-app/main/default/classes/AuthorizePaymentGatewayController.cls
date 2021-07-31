public  class AuthorizePaymentGatewayController {
 
    // public string APIkey = '8zQYF7f7r';
  
    // public string transKey = '9nEp79YN59sxa2qW';
   
    // public string Amt = '5';
    // private string cardNum = '5424000000000015';
    // private string expdate = '1220';
    // private string cvvCode = '999';

    //Method to authorize the card to make the payment later
   
    @AuraEnabled
    public static transactionResponse authorizeCard( String cardNum, String cvvCode, String selectMc, String selectYc, String APIkey, String transKey, String Amt) {

        String YearAndMonth = selectYc + '-' + selectMc ;
        System.debug('--==YearAndMonth--=='+YearAndMonth);
        AuthorizeResponseWrapper authorizeObj = new AuthorizeResponseWrapper();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        request.setHeader('content-type', 'application/json');
        string messageBody ='{ "createTransactionRequest": { "merchantAuthentication": { "name":"'+APIkey+'","transactionKey":"'+transKey+'" }, '+
        '"refId": "123456", "transactionRequest": { "transactionType": "authOnlyTransaction", "amount": "'+Amt+'", "payment": { "creditCard": '+
        '{ "cardNumber":"'+cardNum+'","expirationDate":"'+YearAndMonth+'","cardCode":"'+cvvCode+'" } }, "lineItems": { "lineItem": { "itemId": "1", '+
        '"name": "vase", "description": "Cannes logo", "quantity": "18", "unitPrice": "45.00" } }, "tax": { "amount": "4.26", "name": "level2 tax name",'+
        '"description": "level2 tax" }, "duty": { "amount": "8.55", "name": "duty name", "description": "duty description" }, "shipping": '+
        '{ "amount": "4.26", "name": "level2 tax name", "description": "level2 tax" }, "poNumber": "456654", "customer": { "id": "99999456654" },'+
        ' "billTo": { "firstName": "Ellen", "lastName": "Johnson", "company": "Souveniropolis", "address": "14 Main Street", "city": "Pecan Springs",'+
        ' "state": "TX", "zip": "44628", "country": "USA" }, "shipTo": { "firstName": "China", "lastName": "Bayles", "company": "Thyme for Tea", '+
        '"address": "12 Main Street", "city": "Pecan Springs", "state": "TX", "zip": "44628", "country": "USA" }, "customerIP": "192.168.1.1", '+
        '"transactionSettings": { "setting": { "settingName": "testRequest", "settingValue": "false" } }, "userFields": { "userField": [ '+
        '{ "name": "MerchantDefinedFieldName1", "value": "MerchantDefinedFieldValue1" }, { "name": "favorite_color", "value": "blue" } ] } } } }';

        request.setHeader('Content-length', String.valueOf(messageBody.length()));
        request.setBody(messageBody);
        request.setTimeout(60*1000);
        Http http = new Http();
        String responseStr;
        HttpResponse response = http.send(request);
        responseStr = response.getBody();
        System.debug('===resp1==='+responseStr);
        transactionResponse transactionResponseObj=(transactionResponse)JSON.deserialize(responseStr.trim().replace('\ufeff',''), transactionResponse.class);
        System.debug('transactionResponse'+transactionResponseObj);
        return transactionResponseObj;
       
         
    }

    // public class AuthorizeResponseWrapper {
    //     @AuraEnabled
    //     public String transactionResponse ;
    //     @AuraEnabled
    //     public String refId ;
    //     @AuraEnabled
    //     public String messages ;
    // }


    public class transactionResponse {
        @AuraEnabled
        public TransactionResponseInner transactionResponse;
    }
    public class TransactionResponseInner {
        @AuraEnabled
        public  List<Errors> errors;
        @AuraEnabled
        public List<Messages> messages;
        @AuraEnabled
        public String cvvResultCode; 
    }
    public class Errors {
        @AuraEnabled
        public Integer errorCode;
        @AuraEnabled
        public string errorText;
    }
    public class Messages {
        @AuraEnabled
        public Integer code;
        @AuraEnabled
        public string description;
    }       
}