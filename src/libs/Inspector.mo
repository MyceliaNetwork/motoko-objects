import Option "mo:base/Option";
import Result "mo:base/Result";
import Trie "mo:base/Trie";
import Text "mo:base/Text";

import T "types";
import Unwrap "Unwrap";

module {
    public type Value            = T.Value;
    public type Pair             = T.Pair;
    public type ExternalCallable = T.ExternalCallable;

    public type MotokoObject = T.MotokoObject;

    public type ObjectInspector = T.ObjectInspector;

    public func objectInspectorFactory(obj : MotokoObject) : ObjectInspector {
        return object {
            let unwrapper = Unwrap.Unwrapper();
            
            public func getNat(v : Text) : Result.Result<Nat, ()> {
                return getAndApply<Nat>(v, Unwrap.unwrapNat);
            };

            public func getInt(v : Text) : Result.Result<Int, ()> {
                return getAndApply<Int>(v, Unwrap.unwrapInt);
            };

            public func getFloat(v : Text) : Result.Result<Float, ()> {
                return getAndApply<Float>(v, Unwrap.unwrapFloat);
            };

            public func getPrincipal(v : Text) : Result.Result<Principal, ()> {
                return getAndApply<Principal>(v, Unwrap.unwrapPrincipal);
            };

            public func getCallable(v : Text) : Result.Result<ExternalCallable, ()> {
                return getAndApply<ExternalCallable>(v, Unwrap.unwrapCallable);
            };

            public func getBlob(v : Text) : Result.Result<Blob, ()> {
                return getAndApply<Blob>(v, Unwrap.unwrapBlob);
            };

            public func getArray(v : Text) : Result.Result<[Value], ()> {
                return getAndApply<[Value]>(v, Unwrap.unwrapArray);
            };

            public func getPair(v : Text) : Result.Result<Pair, ()> {
                return getAndApply<Pair>(v, Unwrap.unwrapPair);
            };

            public func getText(v : Text) : Result.Result<Text, ()> {
                return getAndApply<Text>(v, Unwrap.unwrapText);
            };

            public func getOptional(v : Text) : Result.Result<?Value, ()> {
                return getAndApply<?Value>(v, Unwrap.unwrapOptional);
            };

            public func getObject(v : Text) : Result.Result<MotokoObject, ()> {
                return getAndApply<MotokoObject>(v, Unwrap.unwrapObject);
            };

            public func hasProperty(name : Text) : Bool {
                Option.isSome(get(name));
            };

            public func mapNat<T>(name : Text, f : (Nat) -> T) : ?T {
                return map(name, f, Unwrap.unwrapNat);
            };

            public func mapInt<T>(name : Text, f : (Int) -> T) : ?T {
                return map(name, f, Unwrap.unwrapInt);
            };

            public func mapFloat<T>(name : Text, f : (Float) -> T) : ?T {
                return map(name, f, Unwrap.unwrapFloat);
            };

            public func mapPrincipal<T>(name : Text, f : (Principal) -> T) : ?T {
                return map(name, f, Unwrap.unwrapPrincipal);
            };

            public func mapCallable<T>(name : Text, f : (ExternalCallable) -> T) : ?T {
                return map(name, f, Unwrap.unwrapCallable);
            };

            public func mapBlob<T>(name : Text, f : (Blob) -> T) : ?T {
                return map(name, f, Unwrap.unwrapBlob);
            };

            public func mapArray<T>(name : Text, f : ([Value]) -> T) : ?T {
                return map(name, f, Unwrap.unwrapArray);
            };

            public func mapPair<T>(name : Text, f : (Pair) -> T) : ?T {
                return map(name, f, Unwrap.unwrapPair);
            };

            public func mapText<T>(name : Text, f : (Text) -> T) : ?T {
                return map(name, f, Unwrap.unwrapText);
            };

            public func mapOptional<T>(name : Text, f : (?Value) -> T) : ?T {
                return map(name, f, Unwrap.unwrapOptional);
            };

            public func mapObject<T>(name : Text, f : (MotokoObject) -> T) : ?T {
                return map(name, f, Unwrap.unwrapObject);
            };

            func map<T, N>(name : Text, f : (T) -> N, unwrap : (Value) -> Result.Result<T, ()>) : ?N {
                switch(getAndApply(name, unwrap)) {
                    case (#err)   {null};
                    case (#ok(v)) {?f(v)};
                };
            };

            func getAndApply<T>(name : Text, f : (Value) -> Result.Result<T, ()>) : Result.Result<T, ()> {
                switch(get(name)) {
                    case (null) {return #err()};
                    case (?v)   {return f(v)};
                }
            };

            func get(name : Text) : ?Value {
                return Trie.get(obj, {key = name; hash = Text.hash(name)}, Text.equal);
            }
        };
    };
}