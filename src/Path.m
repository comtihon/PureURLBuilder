//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Path.h"
#import "FinalURL.h"
#import "StringTokenizer.h"


@implementation Path
{

}
- (id)initWithName:(NSString *)name andNext:(URL *)next
{
    self = [super initWithNext:next];
    if (self)
    {
        mName = [name copy];
    }

    return self;
}

- (void)format:(NSMutableString *)out
{
    if (!mName)
        return;

    if (![mName length] || [mName characterAtIndex:0] != '/')
        [out appendString:@"/"];
    StringTokenizer *tokenizer = [[StringTokenizer alloc] initWithString:mName andDelimeters:@"/" andOrder:YES];
    for (NSString *element in [tokenizer split])
    {
        if([@"/" isEqualToString:element])
            [out appendString:element];
        else if ([element length])
            [out appendString:[self urlEncode:element]];
    }
    [tokenizer release];
}

- (void)store:(FinalURL *)storage
{
    if (!storage.mPath)
        [storage setPath:self];
}

- (NSString *)getStringContent
{
    return mName? mName : @"";
}

- (void)dealloc
{
    [mName release];
    [super dealloc];
}

@end