import { LightningElement, wire, track } from 'lwc';
import getSobjectRecords from '@salesforce/apex/DynamicKanbanMainComponentController.getSobjectRecords';
import updateTask from '@salesforce/apex/DynamicKanbanMainComponentController.updateAcc';
import { getListUi } from 'lightning/uiListApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity'
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName'
import ID_FIELD from '@salesforce/schema/Opportunity.Id'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DynamicKanbanMainComponent extends LightningElement {
    records
    pickVals
    recordId

    @track displayFields;   
    @track displayParentFields; 
    @track displayChildFields = []; 
    @track childRecordList = [] ; 
    @track parentRecordList = [] ; 
    @track displayRecords;
    @track records;
    @track parentRec;
    @track boolVisible = true;  
    @track dropTaskId;
    @track childRelationshipName;
    /*** fetching Opportunity lists ***/
    @wire(getListUi, {
        objectApiName: OPPORTUNITY_OBJECT,
        listViewApiName:'AllOpportunities'
    })wiredListView({error, data}){
        if(data){
            console.log("getListUi", data)
            this.records = data.records.records.map(item => {
                let field = item.fields
                console.log("field", field);
                let account = field.Account.value.fields
                console.log("account", account);
                return { 'Id': field.Id.value, 'Name': field.Name.value, 'AccountId': account.Id.value, 'AccountName': account.Name.value, 'CloseDate': field.CloseDate.value, 'StageName': field.StageName.value, 'Amount': field.Amount.value }

            })

            console.log(" this.records",  this.records);
        }
        if(error){
            console.error(error)
        }
    }

/** Fetch metadata abaout the opportunity object**/
@wire(getObjectInfo, {objectApiName:OPPORTUNITY_OBJECT})
objectInfo
/*** fetching Stage Picklist ***/

    @wire(getPicklistValues, {
        recordTypeId:'$objectInfo.data.defaultRecordTypeId',
        fieldApiName:STAGE_FIELD
    })stagePicklistValues({ data, error}){
        if(data){
            console.log("Stage Picklist", data)
            this.pickVals = data.values.map(item => item.value)
        }
        if(error){
            console.error(error)
        }
    }


    /****getter to calculate the  width dynamically*/
    get calcWidth(){
        let len = this.pickVals.length +1
        return `width: calc(100vw/ ${len})`
    }

    handleListItemDrag(event){
        this.recordId = event.detail
        console.log(" handleListItemDrag",  this.recordId);
    }

    taskDragStart(event){
        const taskId = event.target.id.substr(0,18);
        console.log(" taskDragStart==taskId==",  taskId);
        //window.alert(taskId);
        this.dropTaskId = taskId;
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        console.log(" taskDragStart==draggableElement==",  draggableElement);
        draggableElement.classList.add('drag'); 
        //this.handleTaskDrag(taskId);
    }

    taskDragEnd(event){
        const taskId = event.target.id.substr(0,18);
        console.log(" taskDragEnd==taskId==",  taskId);
        //window.alert(taskId);
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        console.log(" taskDragEnd==draggableElement==",  draggableElement);
        draggableElement.classList.remove('drag');
    }

    handleDrop(event){
        this.cancel(event);
        const columnUsed = event.target.id;
        let taskNewStatus;
        console.log(" handleDrop==columnUsed==",  columnUsed);
        let targetId1 = event.target.dataset.targetId;
        console.log(" handleDrop==targetId1==",  targetId1);
        // if(columnUsed.includes('InProgress')){
        //     taskNewStatus = 'In Progress';
        // }else if(columnUsed.includes('newTask')){
        //     taskNewStatus = 'Not Started';
        // }else if(columnUsed.includes('completed')){
        //     taskNewStatus = 'Completed';
        // }
        //window.alert(columnUsed + ' & '+ taskNewStatus);
        this.updateTaskStatus(this.dropTaskId, targetId1);
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        draggableElement.classList.remove('over'); 
       
        
    }

    handleDragEnter(event){
        this.cancel(event);
    }

    handleDragOver(event){
        this.cancel(event);
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        draggableElement.classList.add('over');
    }

    handleDragLeave(event){
        this.cancel(event);
        let draggableElement = this.template.querySelector('[data-role="drop-target"]'); 
        draggableElement.classList.remove('over');
    }




    cancel(event) {
        if (event.stopPropagation) event.stopPropagation();
        if (event.preventDefault) event.preventDefault();
        return false;
    };


    updateTaskStatus(conId, accId){
        updateTask({newConId: conId, newAccId: accId, childObjRelationsName :this.childRelationshipName}).then(result =>{
            this.submitObjAndFields();
        }).catch(error =>{
            window.alert('$$$Test2:'+ JSON.stringify(error));
        })
    }

    submitObjAndFields(event) {
    
        console.log(event.target.label);
        var inp=this.template.querySelectorAll("lightning-input");
        this.compareData = 0;

        inp.forEach(function(element){
            if(element.name=="input1")
                this.primaryObject = element.value;

            else if(element.name=="input2")
                this.secondaryObject = element.value;

            else if(element.name=="input4")
                this.secondaryObjSelectedFields = element.value;
        },this);

        getSobjectRecords({primaryObject : this.primaryObject,
                    secondaryObject : this.secondaryObject,
                    secondaryObjSelectedFields : this.secondaryObjSelectedFields })

        .then(result => {
            if(result != null && result != undefined) {
                this.boolVisible = false; 
                let previousIndex = 0; 
                var uiRecords1 = [];     
                const parentRecordsLst = []; 
                const childRecordsLst = []; 
                const childRecordsLst1 = []; 
               
                this.records = JSON.parse(JSON.stringify(result[0].childRecords));  
                this.parentRec = JSON.parse(JSON.stringify(result[0].parentRecords));
                this.displayFields =JSON.parse(JSON.stringify(result[0].parentRecords));   
                this.displayChildFields = JSON.parse(JSON.stringify(result[0].childObjFields)); 
                this.childRelationshipName = JSON.parse(JSON.stringify(result[0].childObjRelationName)); 
                var con = this.childRelationshipName;
                //this.displayParentFields =JSON.parse(JSON.stringify(result[0].parentObjFields));
                //this.displayParentFields =JSON.parse(JSON.stringify(result[0].parentObjFields.length));
                // console.log("==records==="+JSON.stringify(result[0].parentRecords)); 
                 //console.log("==records===@@@"+JSON.stringify(result[0].childObjFields)); 
                //console.log("==records==="+JSON.stringify(this.displayChildFields)); 
                //console.log("==records==="+this.displayChildFields); 
                // console.log("==records===@@@"+JSON.stringify(result[0].childObjFields));
                
                // console.log("@@@==records===@@"+JSON.stringify(result[0].parentRecords[con])); 
                // //console.log("@@@==records===@@"+JSON.stringify(result[0].parentRecords["Contacts"][0])); 


                for(var i = 0; i < Number(this.parentRec.length); i++) { 
                    var uiRecords = [];
                    var uiRecords2 ;
                    var uiRecords3 = [];
                    var uiRecords4 = [];
                   // console.log("@@@==records===@@"+JSON.stringify(result[0].parentRecords[i][con])); 
                    //console.log("@@@==Number(result[0].parentRecords[i][con].length)===@@@"+JSON.stringify(result[0].parentRecords[i])); 
                    //console.log("@@@==Number(result[0].parentRecords[i][con].length)===@@@"+JSON.stringify(result[0].parentRecords[i][con])); 
                    for(var j = 0; j < Number(result[0].parentObjFields.length); j++) {     
                        uiRecords.push(result[0].parentRecords[i][result[0].parentObjFields[j]]); 
                        console.log("==uiRecords===parentRecordsLst==@@@"+JSON.parse(JSON.stringify(uiRecords)));  
                    }
                    
                    if(typeof JSON.stringify(result[0].parentRecords[i][con]) !== "undefined"){
                         console.log("==uiRecords2==comeee");
                        for(var k = 0; k < Number(result[0].parentRecords[i][con].length); k++) {
                            var uiRecords2 = [];
                            for(var l = 0; l < Number(result[0].childObjFields.length); l++) {
                                uiRecords2.push(result[0].parentRecords[i][con][k][result[0].childObjFields[l]]); 
                                

                            }
                            //uiRecords4.push("Id": );
                            console.log("==uiRecords2==",uiRecords2);
                            //childRecordsLst1.push({"Id": result[0].parentRecords[i].Id, "isSelected": true, "rowStyle" : "", "rec" : uiRecords2});
                            uiRecords3.push({"Id":result[0].parentRecords[i][con][k].Id, "uiRec2" :uiRecords2});
                        }
                    }
                    console.log("==uiRecords3==",uiRecords3); 
                    parentRecordsLst.push({"Id": result[0].parentRecords[i].Id, "isSelected": true, "childRec" : uiRecords3, "rec" : uiRecords});
                    console.log("==recordlst==@@@",parentRecordsLst);

                }
                
                this.parentRecordList.push(...parentRecordsLst);
              
                //this.recordList1 = JSON.parse(recordsLst);
                console.log("==recordlst1==",this.parentRecordList);



                // for(var i = 0; i < Number(this.records.length); i++) {
                //     var uiRecords = [];
                //     var uiRecords2 ;
                //     for(var j = 0; j < Number(result[0].childObjFields.length); j++) {
                //         uiRecords.push(result[0].childRecords[i][result[0].childObjFields[j]]); 
                //         console.log("==uiRecords===uiRecords==@@@"+JSON.parse(JSON.stringify(uiRecords))); 
                //         console.log("==displayRecords===displayRecords=="+uiRecords);  
                         
                //     }
             
                //     childRecordsLst.push({"Id": result[0].childRecords[i].Id, "isSelected": true, "rowStyle" : "", "rec" : uiRecords});
                //     console.log("==recordlst==",childRecordsLst);
                   
                // }
                // this.childRecordList.push(...childRecordsLst);
              
                
                // console.log("==recordlst1==",this.childRecordList);

            }
            
        }).catch(error => {
            console.log(error);
            // if(error && error.body && error.body.message)
            //     this.showNotification(error.body.message, 'error');
            //this.showSpinner = false;
        })

        

    }


    itemDragStart(){
        const event = new CustomEvent('itemdrag', {
            detail: this.record.Id
        })
        this.dispatchEvent(event)
    }

    drag(event) {
        event.dataTransfer.setData("divId", event.target.id);
        console.log("----drag----:");
      }
    
      allowDrop(event) {
        console.log("----allowDrop----:");
        event.preventDefault();
      }

    drop(event) {
    //this.showSpinner = true;  
    event.preventDefault();
    //this.UpdateContactId = event.target.id;
    var divId = event.dataTransfer.getData("divId");
    this.UpdateContactId = divId.split("-")[0];
    let targetId = "table" + event.target.dataset.item + '-'+divId.split("-")[1];
    let target1 = this.template.querySelector(`[id="${targetId}"]`);
    let draggedElement = this.template.querySelector(`[id="${divId}"]`);
    
    // console.log(JSON.stringify(this.accRecWrap[event.target.dataset.item]));
    // this.handleUpdate(
    //     this.UpdateContactId,
    //     this.accRecWrap[event.target.dataset.item].accRec.Id,
    //     this.secondaryObj
    // );
    }


    handleItemDrop(event){
        let stage = event.detail
        // this.records = this.records.map(item=>{
        //     return item.Id === this.recordId ? {...item, StageName:stage}:{...item}
        // })
        this.updateHandler(stage)
    }
    updateHandler(stage){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STAGE_FIELD.fieldApiName] = stage;
        const recordInput ={fields}
        updateRecord(recordInput)
        .then(()=>{
            console.log("Updated Successfully")
            this.showToast()
            return refreshApex(this.wiredListView)
        }).catch(error=>{
            console.error(error)
        })
    }

    showToast(){
        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:'Stage updated Successfully',
                variant:'success'
            })
        )
    }
}