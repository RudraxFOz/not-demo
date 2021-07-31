import LightningDatatable from 'lightning/datatable';
//import the template so that it can be reused
import LookupTemplate from './lookup-template.html';
import { loadStyle } from 'lightning/platformResourceLoader';
import CustomDataTableResource from '@salesforce/resourceUrl/CustomDataTable';

export default class CustomDataTable extends LightningDatatable {
    static customTypes = {
        lookup: {
            template: LookupTemplate,
            typeAttributes: ['uniqueId', 'object', 'icon', 'label', 'displayFields', 'displayFormat', 'placeholder', 'filters']
        }
    };

    constructor() {
        super();
        Promise.all([
            loadStyle(this, CustomDataTableResource),
        ]).then(() => {})
    }
}