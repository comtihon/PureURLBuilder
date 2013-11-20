//
// Created by Valery Tikhonov on 11/13/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "Fragment.h"
#import "FinalURL.h"


@implementation Fragment
{

}
- (id)initWithFragment:(NSString *)fragment andNext:(URL*)next
{
    self = [super initWithNext:next];
    if (self)
    {
        mFragment = [fragment copy];
    }

    return self;
}

- (void)store:(FinalURL *)storage
{
    if(!storage.mFragment)
        [storage setFragment:self];
}

- (void)format:(NSMutableString *)out
{
    if(mFragment && [mFragment length])
        [out appendFormat:@"#%@", mFragment];
}

- (NSString *)getStringContent
{
    return [super getStringContent];
}


- (void)dealloc
{
    [mFragment release];
    [super dealloc];
}

@end