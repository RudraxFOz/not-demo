import { LightningElement, track, wire } from "lwc";
import getAccounts from "@salesforce/apex/DataController.getAccounts";
import updateAccount from "@salesforce/apex/DataController.updateAccount";
//import getContacts from '@salesforce/apex/PaginationController.getContacts';

export default class ParentComponent extends LightningElement {
  // @wire(getAccounts)
  primaryObj ='Account';
  secondaryObj ='Contact';
  accounts;
  fields;
  @track UpdateContactId;
  accRecWrap = [];
  showSpinner = false;
  connectedCallback() {
      this.showSpinner = true;
    getAccounts({pObj: this.primaryObj, sObj: this.secondaryObj})
      .then((data) => {
        if (data) {
          this.accounts = data.listAccount;
          this.fields = data.requiredFields;
          var objWrpList = [];
          for (var i = 0; i < this.accounts.length; i++) {
            var acc = this.accounts[i];
            var accRecords = [];
            for (var j = 0; j < this.fields.length; j++) {
              var string = this.fields[j];
              var field = string.charAt(0).toUpperCase() + string.slice(1);
              if (acc[field] != "undefined" && field != "Name") {
                accRecords.push(acc[field]);
              }
            }
            var obj = {
              accRecList: accRecords,
              accRec: acc,
              tableId: "table" + i
            };
            objWrpList.push(obj);
          }
          this.accRecWrap = objWrpList;
          this.showSpinner = false;
        }
      })
      .catch((error) => {
        this.showSpinner = false;
        console.log("error", JSON.stringify(error));
      });
  }

  //when drag is start this method fires
  drag(event) {
    event.dataTransfer.setData("divId", event.target.id);
    console.log("----drag----:");
  }

  allowDrop(event) {
    console.log("----allowDrop----:");
    event.preventDefault();
  }

  drop(event) {
    this.showSpinner = true;  
    event.preventDefault();
    this.UpdateContactId = event.target.id;
    var divId = event.dataTransfer.getData("divId");
    this.UpdateContactId = divId.split("-")[0];
    let targetId = "table" + event.target.dataset.item + '-'+divId.split("-")[1];
    let target1 = this.template.querySelector(`[id="${targetId}"]`);
    let draggedElement = this.template.querySelector(`[id="${divId}"]`);
   
    console.log(JSON.stringify(this.accRecWrap[event.target.dataset.item]));
    this.handleUpdate(
      this.UpdateContactId,
      this.accRecWrap[event.target.dataset.item].accRec.Id,
      this.secondaryObj
    );
  }

  handleUpdate(contactId, AccountId, SecObj) {
    updateAccount({ conId: contactId, AccId: AccountId, SObj: SecObj})
      .then((result) => {
        console.log("Inside handleUpdate");
      })
      .catch((error) => {
        this.showSpinner = false;
        this.error = error;
      })
      .finally(() => {
        this.connectedCallback();
      });
  }
}