module net.client;


import std.stdio;

struct Start{

    this(int count){
        this.count = count;
        writeln("Start initialized with count: ", count);
    }

    int count;

    void displayCount(){
        writeln("Current count: ", count);
    }
}
