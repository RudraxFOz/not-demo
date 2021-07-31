import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/ContactControllerLwc.getContactList';
const columns = [
    { label : 'First Name', fieldName : 'FirstName'},
    { label : 'LastName', fieldName : 'LastName'},
    { label : 'Title', fieldName : 'Title'},
    { label : 'Phone', fieldName : 'Phone', type : 'Phone'},
    { label : 'Email', fieldName : 'Email', type : 'Email'}
];
export default class InfinityLoading extends LightningElement {
    @track error;
    @track columns = columns;
    @track contacts;
    @track data = [];
    @track data1 = [];
    //@track columns = columnsDefs;
    @track loadMoreStatus;
    @track totalNumberOfRows ;
    //@wire (getContactList) contacts;
    //data1 = contacts.data;
    connectedCallback() {
        getContactList()
        .then(result => {
            console.log("==result==",result.originalTarget);
            this.data = result;
            this.totalNumberOfRows = this.data.length;
            console.log("==Accounts==",this.data);
            console.log("==totalNumberOfRows==",this.totalNumberOfRows);
            this.error = undefined;
            for(let key in result) {
                if(key < 10) {
                    console.log("test in if",result.data[key]);
                    this.data1.push(result.data[key]);
                }
            } 
            console.log("test this.data1",this.data1);
        })
        .catch(error => {
            this.error = error;  
            this.data = undefined;
            console.log("==Accounts11==",this.data);
        });
    }
    loadMoreData(event) {
        console.log("tetetete");
        console.log("this.data1.length",this.data1.length);
        console.log("this.totalNumberOfRows",this.totalNumberOfRows);
        //Display a spinner to signal that data is being loaded
        event.target.isLoading = true;
        //Display "Loading" when more data is being loaded
        this.loadMoreStatus = 'Loading';
        //getContactList()
            //.then((data) => {
                if (this.data1.length >= this.totalNumberOfRows) {
                    event.target.enableInfiniteLoading = false;
                    this.loadMoreStatus = 'No more data to load';
                } else {
                    const currentData = this.data1;
                    //Appends new data to the end of the table
                    const newData = currentData.concat(this.data);
                    this.data1 = newData;
                    this.loadMoreStatus = '';
                }
                event.target.isLoading = false;
            //}));
    }
}