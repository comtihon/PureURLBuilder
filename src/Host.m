//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Host.h"

@implementation Host
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

- (void)store:(FinalURL *)storage
{
    if (![storage mHost])
    {
        [storage setHost:self];
    }
}

- (void)format:(NSMutableString *)out
{
    if (mName)
        [out appendString:mName];
}

- (NSString *)getStringContent
{
    return mName ? mName : @"";
}

- (void)dealloc
{
    [mName release];
    [super dealloc];
}

@end