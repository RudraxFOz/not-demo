import { LightningElement, api, track, wire } from 'lwc';
//import { getRecord } from 'lightning/uiRecordApi';
import getContactList  from '@salesforce/apex/ContactControllerLwc.getContactList';
export default class WireFunction extends LightningElement {
    @api recordId;
    @track contacts;
    @track error;
    //@wire(getRecord, { recordId : '$recordId', fields: ['Account.Name']})
    @wire( getContactList  )
    wiredContacts({ data, error }) {
        if(data) {
            this.contacts = data;
            this.error = undefined;
        } else if(error) {
            this.error = error;
            this.contacts = undefined;
        }
    }
    // get name() {
    //     return this.record.fields.Name.value;
    // }
}