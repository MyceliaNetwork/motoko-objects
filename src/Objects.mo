import Hash "mo:base/Hash";
import Optional "mo:base/Option";
import P "mo:base/Prelude";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";
import T "types";
import Text "mo:base/Text";
import Trie "mo:base/Trie";
import TrieSet "mo:base/TrieSet";
import Unwrap "Unwrap";

module {
    public type Value            = T.Value;
    public type Pair             = T.Pair;
    public type ExternalCallable = T.ExternalCallable;

    public type MotokoObject = T.MotokoObject;

    public type ObjectBuilder = {
        remove : (Text)        -> ObjectBuilder;
        
        putNat : (Text, Nat)   -> ObjectBuilder;
        putInt : (Text, Int)   -> ObjectBuilder;
        putFloat : (Text, Float)               -> ObjectBuilder;
        putPrincipal : (Text, Principal)       -> ObjectBuilder;
        putCallable : (Text, ExternalCallable) -> ObjectBuilder;
        putBlob : (Text, Blob)                 -> ObjectBuilder;
        putArray : (Text, [Value])             -> ObjectBuilder;
        putPair : (Text, Pair)                 -> ObjectBuilder;
        putText : (Text, Text)                 -> ObjectBuilder;
        putEmpty : (Text)                      -> ObjectBuilder;
        putOptional : (Text, ?Value)           -> ObjectBuilder;
        putObject : (Text, MotokoObject)       -> ObjectBuilder;

        build     : ()                         -> Result.Result<MotokoObject, ()>;
    };

    public type ObjectFactory = {
        Builder : () -> ObjectBuilder;
    };

    public type SerializerFunc<T>   = (T)                              -> MotokoObject;
    public type DeserializerFunc<T> = (Unwrap.Unwrapper, MotokoObject) -> Result.Result<T, ()>;

    public type ObjectMapper<T> = object {
        serialize   : (T) -> MotokoObject;
        deserialize : (MotokoObject) -> Result.Result<T, ()>;
    };

    public func serializerFactory<T>(s : SerializerFunc<T>, d : DeserializerFunc<T>) : ObjectMapper<T> {
        let unwrapper = Unwrap.Unwrapper();

        return {
            serialize   = s;
            deserialize = func (v) {d(unwrapper, v)}
        };
    };

    public type SchemaItem   = (Text, T.Type);

    public func schemaItemEqual(l : SchemaItem, r : SchemaItem) : Bool {
        return l.0 == r.0 and l.1 == r.1;
    };

    public func schemaItemHash(v : SchemaItem) : Hash.Hash {
        return 3 * Text.hash(v.0) + T.hashOfType(v.1)
    };

    public type ObjectSchema = [SchemaItem];
    
    func getObjectBuilder(schema : ObjectSchema) : ObjectBuilder {
        return object this = {
            var obj        : MotokoObject = Trie.empty();
            var thisSchema : TrieSet.Set<(Text, T.Type)> = TrieSet.empty();

            func put(k: Text, v: Value) : ObjectBuilder {
                obj := put0(k, v, obj).0;
                
                let itm    = (k, T.typeOf(v));
                thisSchema := TrieSet.put(thisSchema, itm, schemaItemHash(itm), schemaItemEqual);

                return this;
            };

            public func remove(k : Text) : ObjectBuilder {
                obj := remove0(k, obj).0;
                return this;
            };
            
            public func build() : Result.Result<MotokoObject, ()> {
                for (v in schema.vals()) {
                    if (not TrieSet.mem(thisSchema, v, schemaItemHash(v), schemaItemEqual)) {
                        // error
                    }
                };
                return #ok(Trie.clone(obj));
            };

            public func putNat(k : Text, v: Nat) : ObjectBuilder {
                put(k, #Nat(v));
            };

            public func putInt(k : Text, v: Int) : ObjectBuilder {
                put(k, #Int(v));
            };

            public func putFloat(k : Text, v: Float) : ObjectBuilder {
                put(k, #Float(v));
            };

            public func putPrincipal(k : Text, v: Principal) : ObjectBuilder {
                put(k, #Principal(v));
            };

            public func putCallable(k : Text, v: ExternalCallable) : ObjectBuilder {
                put(k, #ExternalCallable(v));
            };

            public func putBlob(k : Text, v: Blob) : ObjectBuilder {
                put(k, #Blob(v));
            };

            public func putArray(k : Text, v: [Value]) : ObjectBuilder {
                put(k, #Array(v));
            };

            public func putPair(k : Text, v: Pair) : ObjectBuilder {
                put(k, #Pair(v));
            };

            public func putText(k : Text, v: Text) : ObjectBuilder {
                put(k, #Text(v));
            };

            public func putEmpty(k : Text) : ObjectBuilder {
                put(k, #Empty());
            };

            public func putOptional(k : Text, v : ?Value) : ObjectBuilder {
                put(k, #Optional(v));
            };

            public func putObject(k : Text, v : MotokoObject) : ObjectBuilder {
                put(k, #Object(v));
            };
        };
    };

    
    public func objectBuilderFactory(schema : ObjectSchema) : ObjectFactory {
        return object {
            public func Builder() : ObjectBuilder {
                return getObjectBuilder(schema);
            };
        };
    };

    public func hasProperty(k : Text, obj : MotokoObject) : Bool {
        return Optional.isSome(get0(k, obj));
    };

    public func putProperty(k : Text, v : Value, obj : MotokoObject) : (MotokoObject, ?Value) {
        return put0(k, v, obj);
    };

    public func getProperty(k : Text, obj : MotokoObject) : ?Value {
        return get0(k, obj)
    };

    public func removeProperty(k : Text, obj : MotokoObject) : (MotokoObject, ?Value) {
        return remove0(k, obj);
    };

    public func mapProperty<R>(k : Text, f : (v : Value) -> R, obj : MotokoObject) : ?R {
        switch(get0(k, obj)) {
            case null       {return null};
            case (?present) {return ?f(present)};
        };
    };

    func get0(k : Text, obj : MotokoObject) : ?Value {
        return Trie.get(obj, key(k), Text.equal);
    };

    func put0(k : Text, v : Value, obj : MotokoObject) : (MotokoObject, ?Value) {
        return Trie.put(obj, key(k), Text.equal, v);
    };

    func remove0(k : Text, obj : MotokoObject) : (MotokoObject, ?Value) {
        return Trie.remove(obj, key(k), Text.equal);
    };

    func key(k : Text) : Trie.Key<Text> {
        return {
            key  = k;
            hash = Text.hash(k);
        }
    }
}