//
//  ChessTable.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTable.h"

@implementation ChessTable

+(ChessTable*)chessTableWithPropertyList:(NSDictionary*)list{
    ChessTable* table = nil;
    @try {
        table = [[[ChessTable alloc] init] autorelease];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        table = nil;
    }
    @finally {
    }
    
    return table;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
