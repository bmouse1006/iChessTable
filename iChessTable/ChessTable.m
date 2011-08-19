//
//  ChessTable.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTable.h"
#import "ChessMatrix.h"
#import "ChessStep.h"

@implementation ChessTable

@synthesize bkImage = _bkImage;
@synthesize matrix = _matrix;
@synthesize historySteps = _historySteps;
@synthesize redoSteps = _redoSteps;

#pragma class method
+(ChessTable*)chessTableWithPropertyList:(NSDictionary*)list{
    ChessTable* table = nil;
    @try {
        table = [[[ChessTable alloc] init] autorelease];
        table.bkImage = [list valueForKey:@"bkImage"];
        table.matrix.height = [(NSNumber*)[list valueForKey:@"height"] intValue];
        table.matrix.width = [(NSNumber*)[list valueForKey:@"width"] intValue];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        table = nil;
    }
    @finally {
    }
    
    return table;
}

#pragma instance method
-(void)performStep:(ChessStep*)step{
    //add more code here
    NSEnumerator* enumerator = [step singleStepEnumerator];
    ChessSingleStep* single = nil;
    while (single = [enumerator nextObject]){
        
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        ChessMatrix* matrix = [[ChessMatrix alloc] init];
        self.matrix = matrix;
        [matrix release];
        self.historySteps = [NSMutableArray arrayWithCapacity:0];
        self.redoSteps = [NSMutableArray arrayWithCapacity:0];
    }
    
    return self;
}

-(void)dealloc{
    self.bkImage = nil;
    self.matrix = nil;
    self.historySteps = nil;
    self.redoSteps = nil;
    [super dealloc];
}

@end
