//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Port.h"


@implementation Port
{

}
- (id)initWithPort:(int)port andNext:(URL *)next
{
    self = [super initWithNext:next];
    if (self)
    {
        mPort = port;
    }

    return self;
}

- (void)store:(FinalURL *)storage
{
    if (![storage mPort])
        [storage setPort:self];
}

- (void)format:(NSMutableString *)out
{
    if (mPort)
        [out appendFormat:@":%d", mPort];
}

- (int)getIntContent
{
    return mPort ? mPort : 80;
}

@end