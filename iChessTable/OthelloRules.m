//
//  OthelloRules.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OthelloRules.h"
#import "Chess.h"
#import "ChessTable.h"
#import "ChessMatrix.h"
#import "ChessPiece.h"
#import "ChessStep.h"

#define OTHELLO_ROUND_PIECE @"roundPiece"

@implementation OthelloRules

-(void)resetChessTable:(Chess*)chess{
    //original status
    //all point has no piece except following four
    //7,7 white
    //8,7 black
    //7,8 black
    //8,8 white
    ChessStep* step = [[ChessStep alloc] init];
    [step addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                   color:ChessWhiteColor]
                at:[MatrixPoint pointWithX:3 andY:3]];
    [step addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                   color:ChessBlackColor]
                at:[MatrixPoint pointWithX:4 andY:3]];
    [step addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                   color:ChessBlackColor]
                at:[MatrixPoint pointWithX:3 andY:4]];
    [step addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                   color:ChessWhiteColor]
                at:[MatrixPoint pointWithX:4 andY:4]];
    
    [chess.table performStep:step saveStep:NO];
    [step release];
    
}

-(BOOL)pieceMovingAllowed{
    return YES;
}

-(ChessPieceColor)firstPlayColor{
    return ChessWhiteColor;
}

-(BOOL)isSelectLegal:(MatrixPoint*)point table:(ChessTable*)table{
    return YES;
}
//check if dropping in the table is legal or not
-(BOOL)isDroppingLegal:(MatrixPoint*)point table:(ChessTable*)table{
    return YES;
}
//check if the moving in table is legal or not
-(BOOL)isMoveLegalFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table{
    return YES;
}
//generate a step for dropping in the table. This instance of step will be passed to table to move/add/delete piece
-(ChessStep*)generateStepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table{
    ChessStep* step = [[[ChessStep alloc] init] autorelease];
    [step addPiece:piece at:to];
    return step;
}
-(ChessStep*)generateStepForMovingFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table{
    ChessStep* step = [[[ChessStep alloc] init] autorelease];
    ChessPiece* piece = [table.matrix pieceAtLocation:from];
    [step movePiece:piece from:from to:to];
    return step;
}
//check if the player is winner
-(ChessPieceColor)winnerInTable:(ChessTable*)table{
    //add more code later
    return ChessMaxColor;
}

-(ChessPieceColor)firstHandPlayer{
    return ChessMaxColor;
}

-(BOOL)hasMoreStepsForPiece:(ChessPiece*)piece table:(ChessTable*)table{
    return NO;
}

@end
