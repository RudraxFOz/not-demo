import { LightningElement, track } from 'lwc';
import findAccounts from '@salesforce/apex/AccountControllerLwc.findAccounts';
export default class AccountConLwc extends LightningElement {
    @track accounts;
    @track error;
    handleKeyChange(event) {
        findAccounts({ searchKey })
        .then(result =>{
            Console.log("===",result);
            this.accounts = result;
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.accounts = undefined;
        })
    }
}