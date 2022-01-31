import T "types";
import Result "mo:base/Result";
import Trie "mo:base/Trie";

module Unwrap {
    public type Value            = T.Value;
    public type Pair             = T.Pair;

    public type ExternalCallable = T.ExternalCallable;
    
    public class Unwrapper() {
        public func unwrapBool(v : Value) : Result.Result<Bool, ()>                 {return unwrapBool(v)};
        public func unwrapNat(v : Value) : Result.Result<Nat, ()>                   {return unwrapNat(v)};
        public func unwrapInt(v : Value) : Result.Result<Int, ()>                   {return unwrapInt(v)};
        public func unwrapFloat(v : Value) : Result.Result<Float, ()>               {return unwrapFloat(v)};
        public func unwrapPrincipal(v : Value) : Result.Result<Principal, ()>       {return unwrapPrincipal(v)};
        public func unwrapCallable(v : Value) : Result.Result<ExternalCallable, ()> {return unwrapCallable(v)};
        public func unwrapBlob(v : Value) : Result.Result<Blob, ()>                 {return unwrapBlob(v)};
        public func unwrapArray(v : Value) : Result.Result<[Value], ()>             {return unwrapArray(v)};
        public func unwrapPair(v : Value) : Result.Result<Pair, ()>                 {return unwrapPair(v)};
        public func unwrapText(v : Value) : Result.Result<Text, ()>                 {return unwrapText(v)};
        public func unwrapEmpty(v : Value) : Result.Result<(), ()>                  {return unwrapEmpty(v)};
        public func unwrapOptional(v : Value) : Result.Result<?Value, ()>           {return unwrapOptional(v)};
        public func unwrapObject(v : Value) : Result.Result<T.MotokoObject, ()>     {return unwrapObject(v)}
    };

    public func unwrapBool(v : Value) : Result.Result<Bool, ()> {
        switch(v) {
            case (#Bool(v)) {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapNat(v : Value) : Result.Result<Nat, ()> {
        switch(v) {
            case (#Nat(v)) {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapInt(v : Value) : Result.Result<Int, ()> {
        switch(v) {
            case (#Int(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapFloat(v : Value) : Result.Result<Float, ()> {
        switch(v) {
            case (#Float(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapPrincipal(v : Value) : Result.Result<Principal, ()> {
        switch(v) {
            case (#Principal(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapCallable(v : Value) : Result.Result<ExternalCallable, ()> {
        switch(v) {
            case (#ExternalCallable(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapBlob(v : Value) : Result.Result<Blob, ()> {
        switch(v) {
            case (#Blob(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapArray(v : Value) : Result.Result<[Value], ()> {
        switch(v) {
            case (#Array(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapPair(v : Value) : Result.Result<Pair, ()> {
        switch(v) {
            case (#Pair(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapText(v : Value) : Result.Result<Text, ()> {
        switch(v) {
            case (#Text(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapEmpty(v : Value) : Result.Result<(), ()> {
        switch(v) {
            case (#Empty(v))  {return #ok()};
            case (_)        {#err};
        }
    };

    public func unwrapOptional(v : Value) : Result.Result<?Value, ()> {
        switch(v) {
            case (#Optional(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };

    public func unwrapObject(v : Value) : Result.Result<T.MotokoObject, ()> {
        switch(v) {
            case (#Object(v))  {return #ok(v)};
            case (_)        {#err};
        }
    };
}