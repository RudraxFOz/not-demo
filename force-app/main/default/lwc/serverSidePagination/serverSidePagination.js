import { LightningElement, track, api } from 'lwc';
import getAccountRecords from '@salesforce/apex/ServerSidePaginationController.getAccountRecords'
export default class ServerSidePagination extends LightningElement {
    @track accounts  ;
    @track perPage = 5;

    connectedCallback() {
        getAccountRecords({
            dropDownValue : this.perPage
        })

            .then(result => {
                console.log("==result==",result);
                this.Accounts = result;
                console.log("==Accounts==",this.Accounts);
                this.error = undefined;
               
            })
            .catch(error => {
                this.error = error;
                
                this.accounts = undefined;
                console.log("==Accounts11==",this.Accounts);
            });
   } 

   changeDropDownValue( event ) {
        this.perPage = event.target.value;
   }

   clickNext() {
    console.log("helloooo");
    getAccountRecords({
        dropDownValue : this.perPage
    })
    .then(result => {
        console.log("==11result11==",result);
        this.Accounts = result;
        console.log("==111Accounts11==",this.Accounts);
        this.error = undefined;
       
    })

   }

}