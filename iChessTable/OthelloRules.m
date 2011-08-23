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

-(BOOL)isDroppingLegal:(ChessPoint*)point inTable:(ChessTable*)table{
    return NO;
}

-(BOOL)isMovingLegal:(NSArray*)pointArray inTable:(ChessTable*)table{
    return NO;
}

-(ChessStep*)generateStepForDropping:(ChessPoint*)point inTable:(ChessTable*)table{
    return nil;
}

-(ChessStep*)generateStepForMoving:(NSArray*)pointArray inTable:(ChessTable*)table{
    return nil;
}

-(BOOL)doesCurrentPlayerWin:(ChessTable*)table color:(NSString*)color{
    return NO;
}

@end
