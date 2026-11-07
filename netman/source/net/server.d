module net.server;
import std.stdio;


struct End{
    this(int count){
        this.count = count;
    }

    int count;

    void displayCount(){
        writeln("Current count: ", count);
    }
}