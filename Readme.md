##Pure URL builder for ios.
This library is a simple url builder with `fluent interface build pattern`, with clean and comfortable style ([[[[[[[[[you will] not] have] to] create] a] lot] of] brackets]).

####Creation with scheme:
You can create url with different schemas:  
For url with http:

    URL *google = [[URL http] retain];
For url with https:

    URL *google = [[URL https] retain];
For url with empty schema:

    URL *google = [[URL empty] retain];
####Scheme management
Add or change scheme with `withScheme` method, passing NSString as a scheme:

    URL *google = [[URL empty].withHost(@"google.com").withScheme(@"http") retain];
To remove scheme - pass `nil`, as a param:

    google.withScheme(nil);
####Host management
You can add or change host to url with `withHost` method, passing NSString as host:

    URL *google = [[URL http].withHost(@"google.com") retain];
To remove host - pass `nil` as a param:

    google.withHost(nil);
####Path management
To add path to url use `withPath` with NSString param:

    google.withPath(@"some/path");
You can also use `withArrayPath`, passing NSArray of NSStrings to it:

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"some"];
    [array addObject:@"path"];
    google.withArrayPath(array);
To remove path - pass nil as a parameter;
####Patameter management:

For basic parameters use `withParam` method, based on a type of param:

    google.withStringParam(@"one",@"foo").withStringParam(@"two", @"foo");
    google.withIntParam(@"foo2",15);
For array param use `withArrayParam`, passing NSArray, as a param:

    NSArray *array = [NSArray arrayWithObjects:@"31", @"32", nil];
    URL *params = google.withArrayParam(@"c", array);
To override param - use `withParam` method, based on a type of param, with the same key once again - parameter will be overrided with a new value:

    google.withStringParam(@"one",@"foo").withStringParam(@"one", @"bar");
To remove param - override it with `nil`.
####Port management:
To set or override port - use `withPort` method:

    [URL http].withHost(@"google.com").withPort(9001);
You can't remove port after you specified one, but you can revert it to default (80), passing 0 to it. 
####Using created URL
To buld URL as a NSString - use `toString` method:

    [google toString];
####Memory management:
Pattern fluent interface return autoreleased object each time. Previous object is retained in current. To store URL object you must retain last object:

    URL *google = [[URL http].withHost(@"google.com").withPath(@"search") retain];
Here `http` creates autoreleased object with scheme, which is retained in `host` object, which is retained in `path` object. You need to retain `path` object, cause, if you do not do so - it will be autoreleased and will release all autoreleased chain.  
Pattern overrides your variable (google) with new return value, when you called building url methods. So - it is **important** to rememder to release retained on previous step object, when you want to fill it:

    [google release];
    google = [google.withStringParam(@"uid", @"anotherUid").withIntParam(@"currency", 5000) retain];
Here you release the tail, which you retained earlier, as it will be retained in new param added. Variable `google` will be overriten and if you do not released it - you will loose memory. New tail needed to be retained now.  
*Short and simple rule* - `to save URL - retain its tail. To release URL - release its tail.`  
If you create url and build it in a moment (`[[URL http].withHost(@"google.com") toString]`) - it will return you autoreleased NSString. So if you want to save string - do not forget to retain it.
####Examples:

    [[URL http]
            .withHost(@"microsoft.com")
            .withPort(8080)
            .withPath(@"security/pc-security")
            .withIntParam(@"wfredirect", 1)
            .withStringParam(@"encrypt", @"aes")
            .withStringParam(@"lang", @"default")
            .withBoolParam(@"getLinux", YES) toString]
creates `http://microsoft.com:8080/security/pc-security?getLinux=true&lang=default&encrypt=aes&wfredirect=1`  
For more examples see tests...