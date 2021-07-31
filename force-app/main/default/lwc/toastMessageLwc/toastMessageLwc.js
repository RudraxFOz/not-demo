import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastMessage extends LightningElement {
    msg = '';
    msgchange(event){
        this.msg = event.target.value;
    }
    ShowToastMessage() {
        const toastEvnt = new  ShowToastEvent( {
              title: 'Welcome in Apex Hours' ,
              message: this.msg ,
              variant: 'success' ,
        });
        this.dispatchEvent (toastEvnt);
   }
}