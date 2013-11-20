//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "URL.h"
#import "Host.h"
#import "Port.h"
#import "Scheme.h"
#import "Path.h"
#import "ArrayPath.h"
#import "Fragment.h"
#import "Param.h"
#import "ArrayParam.h"
#import "StringTokenizer.h"

@implementation URL
{

}

+ (URL *) http
{
    return [[[Scheme alloc] initWithScheme:@"http" andNext:nil] autorelease];
}

+ (URL *) https
{
    return [[[Scheme alloc] initWithScheme:@"https" andNext:nil] autorelease];
}

+ (URL *) empty
{
    return [[[URL alloc] initWithNext:nil] autorelease];
}

+ (URL *)parse:(NSString *)src
{
    NSURL *url = [NSURL URLWithString:src];
    URL *result = [URL empty].withScheme([url scheme]);

    NSString *host = [url host];
    if (host && [host length])
        result = result.withHost(host);


    int port = [[url port] intValue];
    if (port >= 0)
        result = result.withPort(port);

    NSString *path = [[url path] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    if (path && [path length])
        result = result.withPath([self parsePath:path]);

    NSString *query = [[[url query] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (query && [query length])
        result = [URL parseQuery:result andQuery:query];

    return result;
}

+ (URL *)parseQuery:(URL *)result andQuery:(NSString *)query
{
    for (NSString *part in [query componentsSeparatedByString:@"&"])
    {
        NSArray *kvp = [part componentsSeparatedByString:@"="];
        NSString *key = [NSString stringWithUTF8String:[[kvp objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding]];
        NSString *value = [kvp count] == 2 ? [NSString stringWithUTF8String:[[kvp objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]] : nil;
        result = result.withStringParam(key, value);
    }

    return result;
}

+ (NSString *)parsePath:(NSString *)path
{
    NSMutableString *out = [NSMutableString string];

    StringTokenizer *tokenizer = [[StringTokenizer alloc] initWithString:path andDelimeters:@"/" andOrder:YES];
    for (NSString *element in [tokenizer split])
    {
        if ([@"/" isEqual:element])
            [out appendString:@"/"];
        else if ([element length])
            [out appendString:[NSString stringWithUTF8String:[element cStringUsingEncoding:NSUTF8StringEncoding]]];
    }
    [tokenizer release];
    return out;
}



- (URL *(^)(NSString *))withHost
{
    return [[^URL *(NSString *name)
    {
        return [[[Host alloc] initWithName:name andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *))withPath
{
    return [[^URL *(NSString *name)
    {
       return [[[Path alloc] initWithName:name andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSArray *))withArrayPath
{
    return [[^URL *(NSArray *value)
    {
        return [[[ArrayPath alloc] initWithParts:value andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(int))withPort
{
    return [[^URL *(int port)
    {
        return [[[Port alloc] initWithPort:port andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *))withScheme
{
    return [[^URL *(NSString *scheme)
    {
        return [[[Scheme alloc] initWithScheme:scheme andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *))withFragment
{
    return [[^URL *(NSString *fragment)
    {
        return [[[Fragment alloc] initWithFragment:fragment andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *, int ))withIntParam
{
    return [[^URL *(NSString *key, int value)
    {
        return [[[Param alloc] initWithValue:[NSString stringWithFormat:@"%d", value] Key:key andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *, long ))withLongParam
{
    return [[^URL *(NSString *key, long value)
    {
        return [[[Param alloc] initWithValue:[NSString stringWithFormat:@"%ld", value] Key:key andNext:self] autorelease];
    } copy] autorelease];
}


- (URL *(^)(NSString *, BOOL))withBoolParam
{
    return [[^URL *(NSString *key, BOOL value)
    {
        return [[[Param alloc] initWithValue: value? @"true" : @"false" Key:key andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *, NSString *))withStringParam
{
    return [[^URL *(NSString *key, NSString *value)
    {
        return [[[Param alloc] initWithValue: value Key:key andNext:self] autorelease];
    } copy] autorelease];
}


- (URL *(^)(NSString *, char *))withCharParam
{
    return [[^URL *(NSString *key, char *value)
    {
        return [[[Param alloc] initWithValue: [NSString stringWithUTF8String:value] Key:key andNext:self] autorelease];
    } copy] autorelease];
}

- (URL *(^)(NSString *, NSArray *))withArrayParam
{
    return [[^URL *(NSString *key, NSArray *values)
    {
        return [[[ArrayParam alloc] initWithValues:values Key:key andNext:self] autorelease];
    } copy] autorelease];
}

-  (URL *(^)(NSDictionary *))withDictParam
{
    return [[^URL *(NSDictionary *values)
    {
        URL *next = self;
        for (NSString *key in values)
        {
            next = [[[Param alloc] initWithValue:key Key:[values objectForKey:key] andNext:next] autorelease];
        }
        return next;
    } copy] autorelease];
}

- (id)initWithNext:(URL *)next
{
    self = [super init];
    if (self)
    {
        mNext = [next retain];
    }

    return self;
}

- (NSString *)toString
{
    return [[self toFinalUrl] toString];
}

- (FinalURL *)toFinalUrl
{
    FinalURL *out = [[FinalURL alloc] init];

    URL *item = self;
    while (item)
    {
        [item store:out];
        item = item.mNext;
    }

    return [out autorelease];
}

- (void)build:(NSMutableString *)out
{
    [[self toFinalUrl] build:out];
}

- (NSString *)urlEncode:(NSString *)original
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *) [original UTF8String];
    int sourceLen = strlen((const char *) source);
    for (int i = 0; i < sourceLen; ++i)
    {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ')
        {
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                (thisChar >= 'a' && thisChar <= 'z') ||
                (thisChar >= 'A' && thisChar <= 'Z') ||
                (thisChar >= '0' && thisChar <= '9'))
        {
            [output appendFormat:@"%c", thisChar];
        } else
        {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (void)store:(FinalURL *)storage
{
}

- (void)format:(NSMutableString *)out
{
}

- (NSString *)getStringContent
{
    return @"";
}

- (int)getIntContent
{
    return 0;
}

- (URL *)mNext
{
    return mNext;
}


- (void)dealloc
{
    [mNext release];
    [super dealloc];
}

@end