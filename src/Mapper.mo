import T "types";
import Unwrap "Unwrap";
import Result "mo:base/Result";
import Inspector "Inspector";
import Builder "ObjectBuilder";

module {
    public type Value            = T.Value;
    public type Pair             = T.Pair;
    public type ExternalCallable = T.ExternalCallable;

    public type MotokoObject = T.MotokoObject;

    public type SerializerFunc<T>   = (T, Builder.ObjectBuilder)        -> MotokoObject;
    public type DeserializerFunc<T> = (MotokoObject, T.ObjectInspector) -> Result.Result<T, ()>;

    public type ObjectMapper<T> = {
        serialize   : (T) -> MotokoObject;
        deserialize : (MotokoObject) -> Result.Result<T, ()>;
    };

    public func mapperFactory<T>(schema : Builder.ObjectSchema, s0 : SerializerFunc<T>, d0 : DeserializerFunc<T>) : ObjectMapper<T> {
        let unwrapper      = Unwrap.Unwrapper();
        let builderFactory = Builder.objectBuilderFactory(schema);

        let s = func (v : T) : MotokoObject {
           s0(v, builderFactory.Builder()) 
        };

        let d = func (v : MotokoObject) : Result.Result<T, ()> {
                let inspector = Inspector.objectInspectorFactory(v);
                d0(v, inspector);
        };

        return {
            serialize   = s;
            deserialize = d;
        };
    };
}