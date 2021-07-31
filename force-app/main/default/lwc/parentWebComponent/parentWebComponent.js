import { LightningElement } from 'lwc';

export default class ParentWebComponent extends LightningElement {
    handleClick(){
        this.template.querySelector("c-child-Web-Component").handleValueChange();
    }
}