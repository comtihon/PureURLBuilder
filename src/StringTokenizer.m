//
// Created by Valery Tikhonov on 11/14/13.
// Copyright (c) 2013 Valery Tikhonov. All rights reserved.
//


#import "StringTokenizer.h"


@implementation StringTokenizer
{
}

- (id)initWithString:(NSString *)string andDelimeters:(NSString*)delimeters andOrder:(BOOL)returnDel
{
    self = [super init];
    if (self)
    {
        mString = [string copy];
        mDelimeters = [delimeters copy];
        mOrder = returnDel;
    }

    return self;
}

- (void)addString:(const char*)source andArray:(NSMutableArray *)out
{
    NSString *parsed = [NSString stringWithCString:source encoding:NSUTF8StringEncoding];
    [out addObject:parsed];
}

- (void)doSplit:(NSMutableArray *)out andSource:(const char*)string andDelemeters:(const char*)delimeters
{
    char *posPtr = strchr(string, delimeters[0]);
    size_t pos = posPtr-string+1;

    char *currPtr;
    size_t currPos;

    for(int i = 1; i < strlen(delimeters); i++)
    {
        currPtr = strchr(string, delimeters[i]);
        if(!currPtr)
            continue;
        currPos = currPtr-string+1;
        if(currPos < pos)
        {
            pos = currPos;
            posPtr = currPtr;
        }
    }

    if(posPtr)
    {
        char *newPart = malloc(pos);
        strncpy(newPart, string, pos-1);
        newPart[pos-1] = '\0';
        [self addString:newPart andArray:out];
        free(newPart);

        if(mOrder)
        {
            char delimeter[2];
            delimeter[0] = *posPtr;
            delimeter[1] = '\0';
            [self addString:delimeter andArray:out];
        }
        string += pos;
        [self doSplit:out andSource:string andDelemeters:delimeters];
    }
    else
        [self addString:string andArray:out];
}

- (NSArray *)split
{
    NSMutableArray *out = [NSMutableArray array];
    [self doSplit:out
        andSource:[mString cStringUsingEncoding:NSUTF8StringEncoding]
    andDelemeters:[mDelimeters cStringUsingEncoding:NSUTF8StringEncoding]];
    return out;
}

- (void)dealloc
{
    [mString release];
    [mDelimeters release];
    [super dealloc];
}


@end