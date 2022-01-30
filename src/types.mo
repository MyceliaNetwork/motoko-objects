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

    public type ObjectInspector = object {
        hasProperty :  (Text) -> Bool;
        getNat :       (Text) -> Result.Result<Nat, ()>;
        getInt :       (Text) -> Result.Result<Int, ()>;
        getFloat :     (Text) -> Result.Result<Float, ()>;
        getPrincipal : (Text) -> Result.Result<Principal, ()>;
        getCallable :  (Text) -> Result.Result<ExternalCallable, ()>;
        getBlob :      (Text) -> Result.Result<Blob, ()>;
        getArray :     (Text) -> Result.Result<[Value], ()>;
        getPair :      (Text) -> Result.Result<Pair, ()>;
        getText :      (Text) -> Result.Result<Text, ()>;
        getOptional :  (Text) -> Result.Result<?Value, ()>;
        getObject :    (Text) -> Result.Result<MotokoObject, ()>;

        mapNat :       <T>(Text, (Nat) -> (T))              -> ?T;
        mapInt :       <T>(Text, (Int) -> (T))              -> ?T;
        mapFloat :     <T>(Text, (Float) -> (T))            -> ?T;
        mapPrincipal : <T>(Text, (Principal) -> (T))        -> ?T;
        mapCallable  : <T>(Text, (ExternalCallable) -> (T)) -> ?T;
        mapBlob :      <T>(Text, (Blob) -> (T))             -> ?T;
        mapArray :     <T>(Text, ([Value]) -> (T))          -> ?T;
        mapPair :      <T>(Text, (Pair) -> (T))             -> ?T;
        mapText :      <T>(Text, (Text) -> (T))             -> ?T;
        mapOptional :  <T>(Text, (?Value) -> (T))           -> ?T;
        mapObject :    <T>(Text, (MotokoObject) -> (T))     -> ?T;
    };
}