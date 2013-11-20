//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "ArrayPath.h"
#import "FinalURL.h"


@implementation ArrayPath
{

}
- (id)initWithParts:(NSArray *)parts andNext:(URL *)next
{
    self = [super initWithNext:next];
    if (self)
    {
        mParts = [parts retain];
    }

    return self;
}

- (void)store:(FinalURL *)storage
{
    if(!storage.mPath)
        [storage setPath:self];
}

- (NSString *)getStringContent
{
    if(!mParts || ![mParts count])
        return @"";

    NSMutableString *out = [NSMutableString string];
    for(NSString *part in mParts)
        [out appendFormat:@"/%@", part];
    return out;
}

- (void)format:(NSMutableString *)out
{
    if(!mParts)
        return;

    if(![mParts count])
    {
        [out appendString:@"/"];
        return;
    }

    for(NSString *part in mParts)
        [out appendFormat:@"/%@",[self urlEncode:part]];
}


- (void)dealloc
{
    [mParts release];
    [super dealloc];
}

@end