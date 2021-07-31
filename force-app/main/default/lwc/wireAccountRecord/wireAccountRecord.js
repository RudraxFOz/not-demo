import { LightningElement, track, wire } from 'lwc';
import findAcc from '@salesforce/apex/AccountControllerLwc.findAccounts';
export default class WireAccountRecord extends LightningElement {
    @track accounts;
    @track error;
    //@wire(findAcc, {accountName:'$searchKey'})
    @wire(findAcc, { accountName:'$searchKey'}) accounts;
        // wiredContacts({data, error}){
        //     if(data){
        //         this.accounts = data;
        //         this.error = undefined;
        //     }
        //     else if (error) {
        //         this.error = error;
        //         this.accounts = undefined;
        //     }
        // }
}