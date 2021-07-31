trigger ExampleTrigger1 on Contact (before insert) {
        System.debug('hello word');
}