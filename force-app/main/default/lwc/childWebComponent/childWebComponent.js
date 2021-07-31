import { LightningElement, track, api } from 'lwc';

export default class ChildWebComponent extends LightningElement {
    @track value = 100;
    @api handleValueChange() {
        this.value = 200;
    }
}