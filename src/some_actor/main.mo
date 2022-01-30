import SomeLib "../lib/some_lib";
import Time "mo:base/Time";
import Trie "mo:base/Trie";
import Debug "mo:base/Debug";

actor {
    public func greet(name : Text) : async Text {
        return SomeLib.greet(name);
    };

    public func echo(name : Text) : async Text {
        return SomeLib.echoName(name);
    };
};
