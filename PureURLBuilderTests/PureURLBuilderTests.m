//
//  PureURLBuilderTests.m
//  PureURLBuilderTests
//
//  Created by Valery Tikhonov on 11/14/13.
//  Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//

#import "PureURLBuilderTests.h"
#import "FinalURL.h"

@implementation PureURLBuilderTests

- (void)setUp
{
    [super setUp];
    google = [[URL http].withHost(@"google.com") retain];
}

- (void)tearDown
{
    [google release];
    [super tearDown];
}

- (void)testHost
{
    STAssertTrue([@"http://google.com" isEqualToString:[google toString]], @"testing to string");
    STAssertTrue([@"http://microsoft.com" isEqualToString:[google.withHost(@"microsoft.com") toString]], @"testing host change");
    STAssertTrue([@"http://" isEqualToString:[google.withHost(nil) toString]], @"testing host change to nil");
}

- (void)testPath
{
    STAssertTrue([@"http://google.com/test/path" isEqualToString:[google.withPath(@"test/path") toString]], @"testing setting path");
    STAssertTrue([@"http://google.com/test/path" isEqualToString:[google.withPath(@"/test/path") toString]], @"testing setting path with /");
    STAssertTrue([@"http://google.com/" isEqualToString:[google.withPath(@"test/path").withPath(@"") toString]], @"testing overriding path with /");
    STAssertTrue([@"http://google.com" isEqualToString:[google.withPath(@"test/path").withPath(nil) toString]], @"testing overriding path");
    STAssertTrue([@"http://google.com/100%25/%D0%B0+%D0%B1" isEqualToString:[google.withPath(@"100%/а б") toString]], @"testing unicode path encoding");
}

- (void)testArrayPath
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"test"];
    [array addObject:@"path"];
    STAssertTrue([@"http://google.com/test/path" isEqualToString:[google.withArrayPath(array) toString]], @"testing array path");
    [array removeAllObjects];
    STAssertTrue([@"http://google.com/" isEqualToString:[google.withPath(@"test/path").withArrayPath(array) toString]], @"testing empty array path");
    STAssertTrue([@"http://google.com" isEqualToString:[google.withPath(@"test/path").withArrayPath(nil) toString]], @"testing null array path");
    [array addObject:@"100%"];
    [array addObject:@"а б"];
    STAssertTrue([@"http://google.com/100%25/%D0%B0+%D0%B1" isEqualToString:[google.withArrayPath(array) toString]], @"testing unicode array path");
    [array removeAllObjects];
}

- (void)testParam
{
    STAssertTrue([@"http://google.com?foo=bar" isEqualToString:[google.withStringParam(@"foo",@"bar") toString]], @"testing params");
    STAssertTrue([@"http://google.com?foo=ggg" isEqualToString:[google.withStringParam(@"foo",@"bar").withStringParam(@"foo",@"ggg") toString]], @"testing params overriding");
    STAssertTrue([@"http://google.com?b=%D0%B0%D0%B1&a=12" isEqualToString:[google.withStringParam(@"a",@"12").withStringParam(@"b",@"аб") toString]], @"testing params overriding");
}

- (void)testArrayParam
{
    NSArray *array = [NSArray arrayWithObjects:@"31", @"32", nil];
    URL *params = google.withIntParam(@"a", 1)
            .withIntParam(@"b", 2)
            .withArrayParam(@"c", array)
            .withIntParam(@"d", 4)
            .withArrayParam(@"e", array);
    STAssertTrue([@"http://google.com?a=1&e=31&e=32&d=4&c=31&c=32&b=2" isEqualToString: [params toString]], @"array param base test");
    STAssertTrue([@"http://google.com?b=2&a=31&a=32&e=31&e=32&d=4&c=31&c=32" isEqualToString: [params.withArrayParam(@"a", array) toString]], @"array param base test");
}

- (void)testDictionaryParam
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"foo" forKey:@"a"];
    [dict setObject:@"b" forKey:@"аб"];
    STAssertTrue([@"http://google.com?b=%D0%B0%D0%B1&foo=a" isEqualToString: [google.withDictParam(dict) toString]], @"dictionaty test");
}

- (void)testParse
{
    STAssertTrue([@"http://google.com:1234/100%25/%D0%B0+%D0%B1?a=foo&c=&b=%D0%B0%D0%B1"
            isEqualToString:[[URL parse:@"http://google.com:1234/100%25/%D0%B0+%D0%B1?b=%D0%B0%D0%B1&c=&a=foo"] toString]], @"URL parse test");

}

- (void)testEquals
{
    URL *u1 = google.withPath(@"abc").withIntParam(@"a", 1).withIntParam(@"b",2);
    URL *u2 = google.withPath(@"abc").withIntParam(@"b",2).withIntParam(@"a", 1);

    FinalURL *fu1 = [u1 toFinalUrl];

    STAssertTrue([fu1 isEqual:[u2 toFinalUrl]], @"Basic equality test");
    STAssertFalse([fu1 isEqual:[u2.withIntParam(@"c", 3) toFinalUrl]], @"Non equality test");
    STAssertFalse([fu1 isEqual:[u2.withIntParam(@"c", 11) toFinalUrl]], @"Non equality test");
    STAssertFalse([fu1 isEqual:[u2.withHost(@"microsoft.com") toFinalUrl]], @"Non equality test");
    STAssertFalse([fu1 isEqual:[u2.withScheme(@"https") toFinalUrl]], @"Non equality test");
}

- (void)testHashCode
{
    URL *u1 = google.withPath(@"abc").withIntParam(@"a", 1).withIntParam(@"b",2);
    URL *u2 = google.withPath(@"abc").withIntParam(@"b", 2).withIntParam(@"a",1);

    STAssertFalse([[u1 toString] hash] == [[u2 toString] hash], @"Hash of NSString comparing");
    STAssertEquals([[u1 toFinalUrl] hash], [[u2 toFinalUrl] hash], @"Hash of FinalURL comparing");
}

@end
