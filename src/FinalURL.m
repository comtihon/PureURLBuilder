//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "FinalURL.h"

@implementation FinalURL
{

}
- (id)init
{
    self = [super init];
    if (self)
    {
        mStorage = [[NSMutableSet alloc] init];
    }

    return self;
}

- (URL *)mScheme
{
    return mScheme;
}

- (URL *)mHost
{
    return mHost;
}

- (URL *)mPort
{
    return mPort;
}

- (NSSet *)mStorage
{
    return mStorage;
}

- (URL *)mPath
{
    return mPath;
}

- (URL *)mFragment
{
    return mFragment;
}

- (void)setScheme:(URL *)protocol
{
    mScheme = [protocol retain];
}

- (void)setHost:(URL *)host
{
    mHost = [host retain];
}

- (void)setPort:(URL *)port
{
    mPort = [port retain];
}

- (void)setPath:(URL *)path
{
    mPath = [path retain];
}

- (void)setFragment:(URL *)fragment
{
    mFragment = [fragment retain];
}

- (void)setHasArrayParam:(BOOL)value
{
    hasArrayParam = value;
}

- (void)addObject:(id)object
{
    [mStorage addObject:object];
}

- (void)build:(NSMutableString *)out
{
    if (mScheme)
        [mScheme format:out];

    if (mHost)
        [mHost format:out];

    if (mPort)
        [mPort format:out];

    if (mPath)
        [mPath format:out];

    if ([mStorage count])
    {
        [out appendString:@"?"];
        NSEnumerator *iterator = [mStorage objectEnumerator];
        BaseParam *param = [iterator nextObject];
        [param format:out];
        while ((param = [iterator nextObject]))
        {
            [out appendString:@"&"];
            [param format:out];
        }
    }

    if (mFragment)
        [mFragment format:out];
}

- (NSString *)toString
{
    NSMutableString *sb = [NSMutableString string];
    [self build:sb];
    return sb;
}

- (NSString *)getScheme
{
    return mScheme? [mScheme getStringContent] : @"";
}

- (NSString *)getHost
{
    return mHost? [mHost getStringContent] : @"";
}

- (int)getPort
{
    return mPort? [mPort getIntContent] : 80;
}

- (NSString *)getPath
{
    return mPath? [mPath getStringContent] : @"";
}

- (NSString *)getFragment
{
    return mFragment? [mFragment getStringContent] : @"";
}

- (NSArray *)getParamsList
{
    NSMutableArray *out = [NSMutableArray array];
    for(BaseParam *param in mStorage)
    {
        [param storeInArray:out];
    }
    return out;
}

- (BOOL)isEqual:(id)object
{
    if(object == self)
        return YES;

    if([[object class] isEqual:[FinalURL class]])
    {
        FinalURL *rhs = object;
        return [self getPort] == [rhs getPort]
            && [self getScheme] == [rhs getScheme]
                && [self getHost] == [rhs getHost]
                && [self getPath] == [rhs getPath]
                && [self getFragment] == [rhs getFragment]
            && [FinalURL paramEquals:mStorage andSecond:[rhs mStorage]];
    }
    return NO;
}

+ (BOOL) paramEquals:(NSSet*)params1 andSecond:(NSSet*)params2
{
    if([params1 count] != [params2 count])
        return NO;
    return [params1 isEqualToSet:params2];
}

- (NSUInteger) hash
{
    NSUInteger result = (NSUInteger) [self getPort];
    result += [[self getScheme] hash];
    result += [[self getHost] hash];
    result += [[self getPath] hash];
    result += [[self getFragment] hash];

    for(BaseParam *param in mStorage)
    {
        result += [[param getKey] hash];
        result += [param getValueHashCode];
    }

    return result;
}

- (void)dealloc
{
    [mFragment release];
    [mPath release];
    [mPort release];
    [mHost release];
    [mScheme release];
    [mStorage release];
    [super dealloc];
}

@end