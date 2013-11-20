//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "ArrayParam.h"
#import "FinalURL.h"


@implementation ArrayParam
{

}
- (id)initWithValues:(NSArray *)values Key:(NSString *)key andNext:(URL *)next
{
    self = [super initWithKey:key next:next];
    if (self)
    {
        mValues = values ? [values retain] : [[NSArray alloc] init];
    }

    return self;
}

- (void)store:(FinalURL *)storage
{
    [storage addObject:self];
    [storage setHasArrayParam:YES];
}

- (void)storeInArray:(NSMutableArray *)out
{
    for(NSString *value in mValues)
        [out addObject:[[[Param alloc] initWithValue:value Key:mKey andNext:nil] autorelease]];
}


- (void)format:(NSMutableString *)out
{
    [out appendFormat:@"%@=", [self urlEncode:mKey]];

    if ([mValues count])
    {
        NSString *value = [mValues objectAtIndex:0];
        [out appendString:(value ? [self urlEncode:value] : @"")];

        for (NSUInteger i = 1; i < [mValues count]; i++)
        {
            value = [mValues objectAtIndex:i];
            [out appendFormat:@"&%@=%@",
                            [self urlEncode:mKey],
                              (value ? [self urlEncode:value] : @"")];
        }
    }
}

- (NSArray *)getValues
{
    return mValues;
}

- (BOOL)equalValues:(BaseParam *)param2
{
    if ([param2 respondsToSelector:@selector(getValue)])
    {
        NSString *value = [param2 performSelector:@selector(getValue)];
        return [mValues count] == 1 &&
                [value isEqualToString:[mValues objectAtIndex:0]];
    }
    else if ([param2 respondsToSelector:@selector(getValues)])
    {
        NSArray *values = [param2 performSelector:@selector(getValues)];
        if ([values count] != [mValues count])
            return NO;

        for (NSString *item in mValues)
            if(![ArrayParam contains:values andItem:item])
                return NO;
        return YES;
    }
    return NO;
}

+ (BOOL) contains:(NSArray *)array andItem:(NSString *)value
{
    if(!value)
    {
        for(NSString *item in array)
            if(!item)
                return YES;
        return NO;
    }

    for(NSString *item in array)
        if([value isEqual:item])
            return YES;
    return NO;
}

- (int)getValueHashCode
{
    int result = 0;

    for(NSString *value in mValues)
    {
        result += 31;
        result += (value? [value hash] : [@"" hash]);
    }
    return result;
}

- (void)dealloc
{
    [mValues release];
    [super dealloc];
}

@end