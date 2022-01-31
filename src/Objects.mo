import Hash "mo:base/Hash";
import List "mo:base/List";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Optional "mo:base/Option";
import P "mo:base/Prelude";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Trie "mo:base/Trie";
import TrieSet "mo:base/TrieSet";

import T "types";
import Unwrap "Unwrap";
import Inspector "Inspector";
import Builder "ObjectBuilder";
import Mapper "Mapper";

module {
    public type Pair             = T.Pair;
    public type Value            = T.Value;
    public type MotokoObject     = T.MotokoObject;
    public type ExternalCallable = T.ExternalCallable;

    public type ObjectInspector  = Inspector.ObjectInspector;

    public type ObjectFactory = Builder.ObjectFactory;
    public type ObjectSchema  = Builder.ObjectSchema;

    public type SerializerFunc<T>   = Mapper.SerializerFunc<T>;
    public type DeserializerFunc<T> = Mapper.DeserializerFunc<T>;

    public func objectInspectorFactory(obj : MotokoObject) : ObjectInspector {
        return Inspector.objectInspectorFactory(obj);
    };

    public func objectBuilderFactory(s : ObjectSchema) : ObjectFactory {
        return Builder.objectBuilderFactory(s);
    };

    public func mapperFactory<T>(schema : ObjectSchema, s : SerializerFunc<T>, d : DeserializerFunc<T>) : Mapper.ObjectMapper<T> {
        return Mapper.mapperFactory(schema, s, d);
    };
}