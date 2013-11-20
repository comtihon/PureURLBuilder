//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Scheme.h"
#import "FinalURL.h"


@implementation Scheme
{

}
- (id)initWithScheme:(NSString *)scheme andNext:(URL *) next
{
    self = [super initWithNext:next];
    if (self)
    {
        mScheme = [scheme copy];
    }

    return self;
}

- (NSString *)getStringContent
{
    return mScheme? mScheme : @"";
}

- (void)store:(FinalURL *)storage
{
    if(!storage.mScheme)
        [storage setScheme:self];
}

- (void)format:(NSMutableString *)out
{
    if(mScheme && [mScheme length])
        [out appendFormat:@"%@://", mScheme];
}

- (void)dealloc
{
    [mScheme release];
    [super dealloc];
}

@end