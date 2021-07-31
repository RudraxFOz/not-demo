import { LightningElement , track, wire} from 'lwc';
import getRecords from '@salesforce/apex/CustomTreeGridController.getRecords';
import getChildRecords from '@salesforce/apex/CustomTreeGridController.getChildRecords';
export default class customTreeGrid extends LightningElement {
    @track primaryObject;
    @track secondaryObject;
    @track permissionData;
    @track primaryObjSelectedFields;
    @track secondaryObjSelectedFields;
    @track displayRecords;
    @track records;
    @track displayFields;   
    @track recordList = [] ;  
    @track recordList1 ;  
    @track compareData ;  
    @track count=0;
    @track keyIndex = 0;  


    @track
    tableData =[
                {
                    Name: "United States",
                    Id: 1,
                    iconName: "utility:chevronright",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Massachusetts",
                    Id: 2,
                    iconName: "utility:chevronright",
                    parentId: 1,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Boston",
                    Id: 3,
                    iconName: "",
                    parentId: 2,
                    rowStyle : "hide",
                    nameStyle : "margin-left:20px;"
                },              
                {
                    Name: "New York",
                    Id: 4,
                    iconName: "",
                    parentId : 1,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Vatican City",
                    Id : 5,
                    iconName: "",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Canada",
                    Id : 6,
                    iconName: "utility:chevronright",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Ontario",
                    Id : 7,
                    iconName: "",
                    parentId : 6,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Alberta",
                    Id : 8,
                    iconName: "",
                    parentId : 6,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                }
            ];

    get hasRendered(){
        // eslint-disable-next-line no-console
        console.log('count--->'+this.count);
        if(this.count === 0)
            return true;
        return false;
    }  

    showOrHideChildrenRows(event){ 
        let rowId = event.target.dataset.rowid;
        console.log('==rowId=='+rowId);
        let isExpanded = event.target.dataset.expanded;
        console.log("==isExpanded=="+isExpanded);
        event.target.iconName = JSON.parse(isExpanded) ? "utility:chevronright": "utility:chevrondown";
        event.target.dataset.expanded = JSON.stringify(!JSON.parse(isExpanded));

        this.recordList = this.recordList.map((obj) => {
            if(obj.parentId == rowId &&  !JSON.parse(isExpanded)){
                obj.rowStyle = "";
            }
            if(obj.parentId == rowId && JSON.parse(isExpanded)){
                obj.rowStyle = "hide";
            }
            return obj;
            console.log("==obj=="+obj);
        });
        console.log(this.recordList);


        getChildRecords({objectId :rowId,
                         primaryObject : this.primaryObject,
                         secondaryObject : this.secondaryObject,
                         primaryObjSelectedFields : this.primaryObjSelectedFields,
                         secondaryObjSelectedFields : this.secondaryObjSelectedFields})

        .then(result => {
            if(result != null && result != undefined) {
                
                var table = document.getElementsByClassName("myTable");
                //console.log("==table==="+JSON.stringify(table)); 
                console.log("==table===@@@"+table); 
                //var table = Document.prototype.getElementById("myTable");
                var row = table.insertRow(1);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "NEW CELL1";
                cell2.innerHTML = "NEW CELL2";
                //console.log("==table==="+JSON.stringify(row)); 
                console.log("==table===@@@"+row); 
                //console.log("==table==="+JSON.stringify(cell1)); 
                console.log("==table===@@@"+cell1); 


                let previousIndex = 0; 
                var uiRecords1 = [];     
                const recordsLst = []; 
                this.records = JSON.parse(JSON.stringify(result[0].sObjectRecords)); 
                this.displayFields =JSON.parse(JSON.stringify(result[0].selectFields));  
                console.log("==records==="+JSON.stringify(this.displayFields)); 
                console.log("==records===@@@"+JSON.stringify(result[0].selectFields)); 

                for(var i = 0; i < Number(this.records.length); i++) {
                    var uiRecords = [];
                    var uiRecords2 ;
                    for(var j = 0; j < Number(result[0].selectFields.length); j++) {
                        uiRecords.push(result[0].sObjectRecords[i][result[0].selectFields[j]]); 
                        //uiRecords2 = result[0].sObjectRecords[i][result[0].selectFields[j]]; 
                        console.log("==uiRecords===uiRecords==@@@"+JSON.parse(JSON.stringify(uiRecords))); 
                        console.log("==displayRecords===displayRecords=="+uiRecords);  
                        console.log("==displayRecords===displayRecords=="+JSON.stringify(result[0].selectFields[j]));  
                        console.log("==result[0].sObjectRecords[i]===result[0].sObjectRecords[i]=="+JSON.stringify(result[0].sObjectRecords[i]));  
                        
                    }
        
                //console.log("==uiRecords===uiRecords==@@@"+JSON.parse(JSON.stringify(uiRecords)));  
                //console.log("==displayRecords===displayRecords=="+uiRecords);   
                recordsLst.push({"Id": result[0].sObjectRecords[i].Id, "isSelected": true, "rowStyle" : "", "rec" : uiRecords});
                console.log("==recordlst==",recordsLst);
                //this.recordList.push(recordsLst);
                //this.recordList.push(...recordsLst);
            }
            this.keyIndex+1;  

            this.recordList.push(...recordsLst);

            
            }
    
        }).catch(error => {
            console.log(error);
            // if(error && error.body && error.body.message)
            //     this.showNotification(error.body.message, 'error');
            // //this.showSpinner = false;
        })

    }


    handleClick(event) {
    
        console.log(event.target.label);
        var inp=this.template.querySelectorAll("lightning-input");
        this.compareData = 0;

        inp.forEach(function(element){
            if(element.name=="input1")
                this.primaryObject = element.value;

            else if(element.name=="input2")
                this.secondaryObject = element.value;

            else if(element.name=="input3")
                this.primaryObjSelectedFields = element.value;

            else if(element.name=="input4")
                this.secondaryObjSelectedFields = element.value;
        },this);

        getRecords({primaryObject : this.primaryObject,
                    secondaryObject : this.secondaryObject,
                    primaryObjSelectedFields : this.primaryObjSelectedFields,
                    secondaryObjSelectedFields : this.secondaryObjSelectedFields })

        .then(result => {
            if(result != null && result != undefined) {
                let previousIndex = 0; 
                var uiRecords1 = [];     
                const recordsLst = []; 
                this.records = JSON.parse(JSON.stringify(result[0].sObjectRecords)); 
                this.displayFields =JSON.parse(JSON.stringify(result[0].selectFields));  
                console.log("==records==="+JSON.stringify(this.displayFields)); 
                console.log("==records===@@@"+JSON.stringify(result[0].selectFields)); 

                for(var i = 0; i < Number(this.records.length); i++) {
                    var uiRecords = [];
                    var uiRecords2 ;
                    for(var j = 0; j < Number(result[0].selectFields.length); j++) {
                        uiRecords.push(result[0].sObjectRecords[i][result[0].selectFields[j]]); 
                        //uiRecords2 = result[0].sObjectRecords[i][result[0].selectFields[j]]; 
                        console.log("==uiRecords===uiRecords==@@@"+JSON.parse(JSON.stringify(uiRecords))); 
                        console.log("==displayRecords===displayRecords=="+uiRecords);  
                        console.log("==displayRecords===displayRecords=="+JSON.stringify(result[0].selectFields[j]));  
                        console.log("==result[0].sObjectRecords[i]===result[0].sObjectRecords[i]=="+JSON.stringify(result[0].sObjectRecords[i]));  
                        
                    }
           
                //console.log("==uiRecords===uiRecords==@@@"+JSON.parse(JSON.stringify(uiRecords)));  
                //console.log("==displayRecords===displayRecords=="+uiRecords);   
                recordsLst.push({"Id": result[0].sObjectRecords[i].Id, "isSelected": true, "rowStyle" : "", "rec" : uiRecords});
                console.log("==recordlst==",recordsLst);
                //this.recordList.push(recordsLst);
                //this.recordList.push(...recordsLst);
            }
               this.recordList.push(...recordsLst);
              
                //this.recordList1 = JSON.parse(recordsLst);
                console.log("==recordlst1==",this.recordList);

                //console.log("==uiRecords==="+uiRecords); 
                //this.separatedArray = this.primaryObjSelectedFields.split(',');     
               
                //for(i = 0; i < Number(fieldsValue.length); i++)   {


                
                // }
                // console.log('==00'==+this.separatedArray); 
                //this.totalRecords = result.length;
                // var fieldsColumn = [];
                // for(var i = 0; i < this.fieldsList.length; i++) {
                //     for(var j = 0; j < this.selectedFields.length; j++) {
                //         if(this.fieldsList[i].value == this.selectedFields[j]) {
                //             fieldsColumn.push(this.fieldsList[i]);
                //         }
                //     }
                // }

                // var columnList = [];
                // for(var j = 0; j < fieldsColumn.length; j++) {
                //     columnList.push({'label': fieldsColumn[j].label, 'fieldName': fieldsColumn[j].value, 'type': fieldsColumn[j].datatype});
                // }
                // this.columns = columnList;
            }
            //const accordion = this.template.querySelector('.pagination-accordion');
            //accordion.activeSectionName = 'B';
            //this.showSpinner = false;
        }).catch(error => {
            console.log(error);
            if(error && error.body && error.body.message)
                this.showNotification(error.body.message, 'error');
            //this.showSpinner = false;
        })

        

    }

    // @wire(getRecords)
    // accountTreeData({ error, data }) {

    //     console.log( 'Inside wire' );
    //     if ( data ) {

    //         var tempData = JSON.parse( JSON.stringify( data ) );
    //         console.log( 'Data is ' + tempData );
 
    //         for ( var i = 0; i < tempData.length; i++ ) {

    //             tempData[ i ]._children = tempData[ i ]['Contacts'];
           

    //         }
    //         console.log( 'Inside wire ==tempData==' +tempData);
         

    //     } else if ( error ) {
         
    //         if ( Array.isArray( error.body ) )
    //             console.log( 'Error is ' + error.body.map( e => e.message ).join( ', ' ) );
    //         else if ( typeof error.body.message === 'string' )
    //             console.log( 'Error is ' + error.body.message );

    //     }

    // }
}