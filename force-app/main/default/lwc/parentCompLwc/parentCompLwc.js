import { LightningElement, track } from 'lwc';

export default class ParentCompLwc extends LightningElement {
    @track msg ;
    handleCustomevent(event) {
        const textVal = event.detail;
        this.msg = textVal;
    }
}