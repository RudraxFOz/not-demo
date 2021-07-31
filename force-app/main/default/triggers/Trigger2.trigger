trigger Trigger2 on Account (before update) {
    List<Account> newTriggers = Trigger.new;
    List<Account> oldTriggers = Trigger.old;
    System.debug('We want to set the heap dump marker here');
}