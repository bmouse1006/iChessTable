//
//  ChessStep.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessStep.h"
#import "NSArray+ChessHelper.h"

@implementation ChessSingleStep

@synthesize type = _type;
@synthesize piece = _piece;
@synthesize from = _from;
@synthesize to = _to;

-(ChessSingleStep*)reverse{
    ChessSingleStep* reversed = [[ChessSingleStep alloc] init];
    reversed.piece = self.piece;
    reversed.to = self.to;
    switch (self.type) {
        case ChessSingleStepTypeAdd:
            reversed.type = ChessSingleStepTypeDelete;
            break;
        case ChessSingleStepTypeDelete:
            reversed.type = ChessSingleStepTypeAdd;
            break;
        case ChessSingleStepTypeMove:
            reversed.type = ChessSingleStepTypeMove;
            reversed.from = self.to;
            reversed.to = self.from;
        default:
            break;
    }
    
    return [reversed autorelease];
}

-(void)dealloc{
    self.piece = nil;
    self.from = nil;
    self.to = nil;
    [super dealloc];
}

@end

@implementation ChessStep

@synthesize singleSteps = _singleSteps;

-(ChessStep*)reverse{
    ChessStep* reversedStep = [[[ChessStep alloc] init] autorelease];
    
    NSEnumerator* enumerator = [self.singleSteps reverseObjectEnumerator];
    ChessSingleStep* step = nil;
    while (step = [enumerator nextObject]){
        [reversedStep.singleSteps addObject:[step reverse]];
    }
    
    [reversedStep sortSingleSteps];
    
    return reversedStep;
}

-(void)addPiece:(ChessPiece*)piece at:(MatrixPoint*)location{
    ChessSingleStep* step = [[ChessSingleStep alloc] init];
    step.type = ChessSingleStepTypeAdd;
    step.piece = piece;
    step.to = location; 
    [self.singleSteps addObject:step];
    [step release];
}

-(void)removePiece:(ChessPiece*)piece at:(MatrixPoint*)location{
    ChessSingleStep* step = [[ChessSingleStep alloc] init];
    step.type = ChessSingleStepTypeDelete;
    step.piece = piece;
    step.to = location; 
    [self.singleSteps addObject:step];
    [step release];
}

-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromLocation to:(MatrixPoint*)toLocation{
    ChessSingleStep* step = [[ChessSingleStep alloc] init];
    step.type = ChessSingleStepTypeMove;
    step.piece = piece;
    step.from = fromLocation; 
    step.to = toLocation;
    [self.singleSteps addObject:step];
    [step release];
}

-(NSEnumerator*)singleStepEnumerator{
    return [self.singleSteps objectEnumerator];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.singleSteps = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    return self;
}

-(void)dealloc{
    self.singleSteps = nil;
    [super dealloc];
}

//priority:
//1. remove
//2. move
//3. add
-(void)sortSingleSteps{
    [self.singleSteps sortUsingComparator:^(id obj1, id obj2){
        NSComparisonResult result;
        ChessSingleStepType type1 = ((ChessSingleStep*)obj1).type;
        ChessSingleStepType type2 = ((ChessSingleStep*)obj2).type;
        if (type1 < type2){
            result = NSOrderedAscending;
        }else if (type1 > type2){
            result = NSOrderedDescending;
        }else{
            result = NSOrderedSame;
        }
        
        return result;
    }];
}

@end
