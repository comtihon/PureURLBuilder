//
// Created by Valery Tikhonov on 11/12/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "BaseParam.h"


@implementation BaseParam
{

}
- (id)initWithKey:(NSString *)key next:(URL *)next
{
    if (!key)
        @throw [NSException exceptionWithName:@"Error" reason:@"Key can not be null" userInfo:nil];

    self = [super initWithNext:next];
    if (self)
    {
        mKey = [key copy];
    }

    return self;
}

- (NSString *)getKey
{
    return mKey;
}

- (unsigned int)hash
{
    return 234;
}

- (BOOL)isEqual:(id)other
{
    return other == self ||
            ([other respondsToSelector:@selector(getKey)]
                    && [[other getKey] isEqualToString:mKey]);
}

- (BOOL)equalValues:(BaseParam *)param2
{

}

- (int)getValueHashCode
{
    return 0;
}

- (void)storeInArray:(NSMutableArray *)out
{

}

- (void)dealloc
{
    [mKey release];
    [super dealloc];
}

@end