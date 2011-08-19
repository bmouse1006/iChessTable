//
//  NSArray+ChessHelper.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSArray+ChessHelper.h"

@implementation NSArray (NSArray_ChessHelper)

-(NSArray*)reversedArray{
    NSMutableArray* reversed = [NSMutableArray arrayWithCapacity:0];
    NSEnumerator* enumerator = [self reverseObjectEnumerator];
    id obj;
    while (obj = [enumerator nextObject]){
        [reversed addObject:obj];
    }
    
    return reversed;
}

@end
