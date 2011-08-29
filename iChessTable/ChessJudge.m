//
//  ChessJudge.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessJudge.h"

@implementation ChessJudge

@synthesize rules = _rules;
@synthesize currentPlayer = _currentPlayer;

+(ChessJudge*)judgeWithRules:(id<ChessRules>)rules{
    ChessJudge* judge = [[ChessJudge alloc] init];
    //add more code here
    judge.rules = rules;
    
    return [judge autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.rules = nil;
    [super dealloc];
}

-(BOOL)doesPieceCanBeSelected:(ChessPiece*)piece table:(ChessTable*)table{
    //if pieces of this chess are not allowed to be selected/moved
    //return NO
    //else return YES;
    return [self.rules pieceMovingAllowed];
}

-(BOOL)doesPieceCanBeMoved:(ChessPiece*)piece table:(ChessTable*)table{
    return [self.rules pieceMovingAllowed];
}
-(BOOL)doesPieceCanBeDropped:(ChessPiece*)piece to:(MatrixPoint*)to table:(ChessTable*)table{
    BOOL result = NO;
    return result;
}
-(BOOL)isTouchInTableLegal:(ChessTable*)table location:(MatrixPoint*)location{
    BOOL result = NO;
    return result;
}

-(ChessStep*)stepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table{
    return [self.rules generateStepForDropping:piece to:to inTable:table];
}

-(void)switchPlayer{
    switch (self.currentPlayer) {
        case ChessBlackColor:
            self.currentPlayer = ChessWhiteColor;
            break;
        case ChessWhiteColor:
            self.currentPlayer = ChessBlackColor;
            break;
        case ChessNoneColor:
            break;
        default:
            break;
    }
}

-(ChessColor)winnerInTable:(ChessTable*)table{
    return [self.rules winnerInTable:table];
}

@end
