import { LightningElement } from 'lwc';

export default class ChildComp extends LightningElement {
    handleChange(event) {
        event.preventDefault();
        const textName = event.target.value;
        const selectEvent = new CustomEvent('myCustomevnt',{detail : textName});
        this.dispatchEvent(selectEvent);
    }
}