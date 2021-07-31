import { LightningElement, api, track } from 'lwc';
export default class DynamicKanbanTableList extends LightningElement {
    @api records
    @api stage
    @track updateContactId 
    handleItemDrag(evt){
        const event = new CustomEvent('listitemdrag', {
            detail: evt.detail
        })
        this.dispatchEvent(event)
    }
    handleDragOver(evt){
        evt.preventDefault()
    }
    handleDrop(evt){
        const event = new CustomEvent('itemdrop', {
            detail: this.stage
        })
        this.dispatchEvent(event)
    }
    itemDragStart(){
        const event = new CustomEvent('itemdrag', {
            detail: this.record.Id
        })
        this.dispatchEvent(event)
    }

    drag(event) {
        //event.dataTransfer.setData("divId", event.target.id);
        event.dataTransfer.setData("divId", event.target.id);
        console.log("----drag----:"+event.target.id);
    }
    
    allowDrop(event) {
        
        event.preventDefault();
    }

    drop(event) {
        //this.showSpinner = true;  
        //event.preventDefault();
        //this.UpdateContactId = event.target.id;
        // var divId = event.dataTransfer.getData("divId");
        // console.log("----drop---divId-:"+event.target.id);
        // this.UpdateContactId = divId.split("-")[0];
        // let targetId = "table" + event.target.dataset.item + '-'+divId.split("-")[1];
        // let target1 = this.template.querySelector(`[id="${targetId}"]`);
        // let draggedElement = this.template.querySelector(`[id="${divId}"]`);

        // var divId = event.dataTransfer.getData("divId");
        // var draggedElement = this.template.querySelector('#' +divId);
        // draggedElement.classList.add('completed'); 
        // event.target.appendChild(draggedElement);
        event.preventDefault();

        // event.dataTransfer.dropEffect = 'move';

        // let seqNumber = event.target.dataset.item;
        // console.log('seqNumber ' + seqNumber);

       
        this.updateContactId = event.target.id;
        var divId = event.dataTransfer.getData("divId");
        console.log("----drop---divId-:"+divId);
        this.updateContactId = divId.split("-")[0];
        console.log("----drop---this.updateContactId-:"+this.updateContactId);
        let targetId = "table" + event.target.dataset.item + '-'+divId.split("-")[1];
        let targetId1 = event.target.dataset.item;
        console.log("----drop---targetId-:"+targetId);
        let target1 = this.template.querySelector(`[id="${targetId1}"]`);
        console.log("----drop---target1-:"+target1);
        let draggedElement = this.template.querySelector(`[id="${divId}"]`);
        console.log("----drop---draggedElement-:"+draggedElement);
        draggedElement.classList.add('completed'); 
        event.target.appendChild(draggedElement);
        
       
    }
}