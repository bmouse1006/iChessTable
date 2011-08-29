//
//  ChessRules.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPiece.h"

@class ChessTable, ChessStep, Chess, MatrixPoint;

@protocol ChessRules <NSObject>

@required

//if piece moving is allowed
-(BOOL)pieceMovingAllowed;
-(ChessColor)firstHandPlayer;
//reset the game table to the original status
-(void)resetChessTable:(Chess*)chess;
//chec if select is legal
-(BOOL)isSelectLegal:(MatrixPoint*)point table:(ChessTable*)table;
//check if dropping in the table is legal or not
-(BOOL)isDroppingLegal:(MatrixPoint*)point table:(ChessTable*)table;
//check if the moving in table is legal or not
-(BOOL)isMoveLegalFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table;
//generate a step for dropping in the table. This instance of step will be passed to table to move/add/delete piece
-(ChessStep*)generateStepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table;
-(ChessStep*)generateStepForMovingFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table;
//check if the player is winner
-(ChessColor)winnerInTable:(ChessTable*)table;

@end
