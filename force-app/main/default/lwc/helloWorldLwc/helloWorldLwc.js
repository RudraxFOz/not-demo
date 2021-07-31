import { LightningElement, api } from 'lwc';

export default class HelloWorldLwc extends LightningElement {
    @api firstName = 'Suresh';
    @api strTitle = 'Welcome in salesforce';
    @api showImage = false;
    @api imgUrl = '';
}