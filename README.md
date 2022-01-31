# Motoko Objects
## Motoko Data-interchange Object Libary

## Installing
Add the following to your `package-set.dhall` and run `vessel verify`
```
{ name = "motoko-objects"
, repo = "https://github.com/DepartureLabsIC/motoko-objects"
, version = "v0.1.0"
, dependencies = [ "base" ]
}
```

## Simple Serialization / Deserialization Example

```Motoko
        import Objects "mo:motoko-objects/Objects"

        type SimpleObject = {
            foo : Nat;
            bar : Text;
        };

        let schema : Objects.ObjectSchema = [
            ("foo", #Nat),
            ("bar", #Text),
        ];

        let s : Objects.SerializerFunc<SimpleObject> = func (n, b) {
            b.putNat("foo", n.foo)
             .putText("bar", n.bar)
             .build();
        };

        let d : Objects.DeserializerFunc<SimpleObject> = 
        func (obj, inspector) {
            // Note how we're leveraging pattern matching to make this super clean
            switch(inspector.getNat("foo"), inspector.getText("bar")) {
                case (#ok(v), #ok(v1)) {return #ok({foo = v; bar = v1})};
                case (_, _)   {return #err};
            };
        };

        // Get an object mapper
        let mapper = Objects.mapperFactory(schema, s, d);

        // Serialize SimpleObject into MotokoObject
        switch(mapper.serialize({foo = 123; bar = "test"})) {
            case (#ok(motokoObject))  {
                // Send the result somewhere
            };
            case (#err(_)) {
                // Alert someone
            };
        };

        // Deserialize MotokoObject into SimpleObject
        switch(mapper.deserialize(v)) {
            case (#ok(simpleObject)) {
                // Do something with the simpleObject : SimpleObject
            };
            case (#err) {
                // Alert someone 
            };
        };
```



