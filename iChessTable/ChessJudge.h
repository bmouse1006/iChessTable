//
//  ChessJudge.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessRules.h"

@interface ChessJudge : NSObject{
    id<ChessRules> _rules;
    ChessPieceColor _currentColor;
}

@property (nonatomic, retain) id<ChessRules> rules;
@property (nonatomic, assign) ChessPieceColor currentColor;
//generate a new judge with given rules
+(ChessJudge*)judgeWithRules:(id<ChessRules>)rules;

-(BOOL)piece:(ChessPiece*)piece canBeSelectedInTable:(ChessTable*)table;
-(BOOL)piece:(ChessPiece*)piece canBeMovedFrom:(MatrixPoint*)from to:(MatrixPoint*)to table:(ChessTable*)table;
-(BOOL)piece:(ChessPiece*)piece canBeDroppedTo:(MatrixPoint*)to table:(ChessTable*)table;
-(BOOL)isMovingAllowed;
-(BOOL)isTouchInTableLegal:(ChessTable*)table location:(MatrixPoint*)location;
-(BOOL)couldContinuePlayInTable:(ChessTable*)table;

-(ChessStep*)stepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table;
-(ChessStep*)stepForMoving:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to inTable:(ChessTable*)table;
-(void)switchPlayer;
-(ChessPieceColor)winnerInTable:(ChessTable*)table;

-(void)resetTable:(Chess*)chess;

@end
