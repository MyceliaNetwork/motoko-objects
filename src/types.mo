import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Trie "mo:base/Trie";
import TrieSet "mo:base/TrieSet";

module {
    public type Type = {
        #Bool;

        #Nat; 
        #Int; 

        #Float;

        #Principal;
        #ExternalCallable;
        
        #Blob;

        #Array;
        #Pair;

        #Text;

        #Empty;
        #Optional : Type;

        #Object;
    };

    public func hashOfType(v : Type) : Hash.Hash {
        switch(v) {
            case (#Nat)              {return 0};
            case (#Int)              {return 1};
            case (#Float)            {return 3};
            case (#Principal)        {return 4};
            case (#ExternalCallable) {return 5};
            case (#Blob)             {return 6};
            case (#Array)            {return 7};
            case (#Pair)             {return 8};
            case (#Text)             {return 9};
            case (#Empty)            {return 10};
            case (#Object(v))        {return 11};
            case (#Bool)             {return 12};
            case (#Optional(v))      {return 100 + hashOfType(v)};
        };
    };

    public type ExternalCallable = shared (Value) -> async Value;
    public type InternalCallable = (Value) -> Value;
    public type Pair             = (Value, Value);
    public type MotokoObject     = Trie.Trie<Text, Value>;

    public type Value = {
        #Bool  : Bool;

        #Nat   : Nat; 
        #Int   : Int; 

        #Float : Float;

        #Principal : Principal;

        #ExternalCallable  : ExternalCallable;
        
        #Blob  : Blob;

        #Array : [Value];
        #Pair  : Pair;

        #Text  : Text;

        #Empty;
        #Optional : ?Value;

        #Object : MotokoObject;
    };

    public func typeOf(v : Value) : Type {
        switch(v) {
            case (#Bool(_))             {return #Bool};
            case (#Nat(_))              {return #Nat};
            case (#Int(_))              {return #Int};
            case (#Float(_))            {return #Float};
            case (#Principal(_))        {return #Principal};
            case (#ExternalCallable(_)) {return #ExternalCallable};
            case (#Blob(_))             {return #Blob};
            case (#Array(_))            {return #Array};
            case (#Pair(_))             {return #Pair};
            case (#Text(_))             {return #Text};

            case (#Empty(_))            {return #Empty};
            case (#Optional(?v))        {return #Optional(typeOf(v))};
            case (#Optional(null))      {return #Optional(#Empty)};

            case (#Object(_))           {return #Object};
        };
    };
}