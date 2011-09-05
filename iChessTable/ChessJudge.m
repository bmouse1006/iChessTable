//
//  ChessJudge.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessJudge.h"
#import "ChessRules.h"
#import "ChessTable.h"

@implementation ChessJudge

@synthesize rules = _rules;
@synthesize currentColor = _currentColor;

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
        self.currentColor = ChessWhiteColor;
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
    BOOL result = NO;
    if (piece.color != self.currentColor){
        result = NO;
    }else if (table.movedInThisRound != nil){
        result = NO;
    }else{
        result = [self.rules pieceMovingAllowed];
    }
    return result;
}

-(BOOL)doesPieceCanBeMoved:(ChessPiece*)piece table:(ChessTable*)table{
    return [self.rules pieceMovingAllowed];
}
-(BOOL)doesPieceCanBeDropped:(ChessPiece*)piece to:(MatrixPoint*)to table:(ChessTable*)table{
    return [self.rules isDroppingLegal:to table:table];
}
-(BOOL)isTouchInTableLegal:(ChessTable*)table location:(MatrixPoint*)location{
    BOOL result = NO;
    return result;
}

-(BOOL)couldContinuePlayInTable:(ChessTable*)table{
    return [self.rules hasMoreStepsForPiece:table.movedInThisRound 
                                      table:table];
}

-(ChessStep*)stepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table{
    return [self.rules generateStepForDropping:piece to:to inTable:table];
}

-(ChessStep*)stepForMoving:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to inTable:(ChessTable*)table{
    return [self.rules generateStepForMovingFrom:from to:to table:table];
}

-(void)switchPlayer{
    switch (self.currentColor) {
        case ChessBlackColor:
            self.currentColor = ChessWhiteColor;
            break;
        case ChessWhiteColor:
            self.currentColor = ChessBlackColor;
            break;
        case ChessMaxColor:
            break;
        default:
            break;
    }
    DebugLog(@"NOTIFICATION_GAME_SWITCHPLAYER is send", nil);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GAME_SWITCHPLAYER object:nil];
}

-(ChessPieceColor)winnerInTable:(ChessTable*)table{
    return [self.rules winnerInTable:table];
}

-(void)resetTable:(Chess*)chess{
    DebugLog(@"Chess Judge: reset table", nil);
    [self.rules resetChessTable:chess];
}

@end
