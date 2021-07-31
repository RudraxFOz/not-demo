<aura:application extends="force:slds">
  <aura:attribute name="selectedLookUpRecords" type="sObject[]" default="[]"/>
  <c:cLookupParent objectAPIName="Contact" IconName="standard:contact" lstSelectedRecords="{!v.selectedLookUpRecords}" label="Contact Name"/>
</aura:application>