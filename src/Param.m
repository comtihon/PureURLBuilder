//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Param.h"
#import "FinalURL.h"

@implementation Param
{


}
- (id)initWithValue:(NSString *)value Key:(NSString *)key andNext:(URL *)next
{
    self = [super initWithKey:key next:next];
    if (self)
    {
        mValue = value ? [value copy] : @"";
    }

    return self;
}

- (void)store:(FinalURL *)storage
{
    [storage addObject:self];
}

- (void)format:(NSMutableString *)out
{
    [out appendFormat:@"%@=%@", [self urlEncode:mKey],
                    [self urlEncode:mValue]];
}

- (NSString *)getValue
{
    return mValue;
}

- (BOOL)equalValues:(BaseParam *)param2
{
    if ([param2 respondsToSelector:@selector(getValue)])
        return [mValue isEqualToString:[param2 performSelector:@selector(getValue)]];
    else if ([param2 respondsToSelector:@selector(getValues)])
    {
        NSArray *values = [param2 performSelector:@selector(getValues)];
        return [values count] == 1 && [mValue isEqual:[values objectAtIndex:0]];
    }
    return NO;
}

- (int)getValueHashCode
{
    return 31 + [mValue hash];
}

- (void)storeInArray:(NSMutableArray *)out
{
    [out addObject:self];
}


- (void)dealloc
{
    [mValue release];
    [super dealloc];
}

@end