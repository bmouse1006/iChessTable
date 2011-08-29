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

#define OTHELLO_ROUND_PIECE @"roundPiece"

@implementation OthelloRules

-(void)resetChessTable:(Chess*)chess{
    //original status
    //all point has no piece except following four
    //7,7 white
    //8,7 black
    //7,8 black
    //8,8 white
    MatrixPoint* point = [[MatrixPoint alloc] init];
    point.x = 7;
    point.y = 7;
    [chess.table.matrix addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                                 color:ChessWhiteColor]
                              to:[MatrixPoint pointWithX:7 andY:7]];
    point.x = 7;
    point.y = 8;
    [chess.table.matrix addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                                 color:ChessBlackColor]
                              to:point];
    point.x = 8;
    point.y = 7;
    [chess.table.matrix addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                                 color:ChessBlackColor]
                              to:point];
    point.x = 8;
    point.y = 8;
    [chess.table.matrix addPiece:[chess getPieceByKind:OTHELLO_ROUND_PIECE 
                                                 color:ChessWhiteColor]
                              to:point];
    [point release];
    
}

-(BOOL)pieceMovingAllowed{
    return NO;
}

-(ChessColor)firstPlayColor{
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
    return nil;
}
-(ChessStep*)generateStepForMovingFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table{
    return nil;
}
//check if the player is winner
-(ChessColor)winnerInTable:(ChessTable*)table{
    //add more code later
    return ChessNoneColor;
}

-(ChessColor)firstHandPlayer{
    return ChessNoneColor;
}

@end
