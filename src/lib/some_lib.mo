module {
    public func echoName(name : Text) : Text {
        return name;
    };

    public func greet(name : Text) : Text {
        return "Hello, " # name # "!";
    };
}