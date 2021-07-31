trigger TestYuHi on Contact (after  undelete) {
    YuHi obj = new YuHi();
     if(Trigger.Isundelete)
    {
        obj.afterUndelete(Trigger.new);
    }
}