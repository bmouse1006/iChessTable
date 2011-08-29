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
    ChessColor _currentPlayer;
}

@property (nonatomic, retain) id<ChessRules> rules;
@property (nonatomic, assign) ChessColor currentPlayer;
//generate a new judge with given rules
+(ChessJudge*)judgeWithRules:(id<ChessRules>)rules;

-(BOOL)doesPieceCanBeSelected:(ChessPiece*)piece table:(ChessTable*)table;
-(BOOL)doesPieceCanBeMoved:(ChessPiece*)piece table:(ChessTable*)table;
-(BOOL)doesPieceCanBeDropped:(ChessPiece*)piece to:(MatrixPoint*)to table:(ChessTable*)table;
-(BOOL)isTouchInTableLegal:(ChessTable*)table location:(MatrixPoint*)location;

-(ChessStep*)stepForDropping:(ChessPiece*)piece to:(MatrixPoint*)to inTable:(ChessTable*)table;
-(void)switchPlayer;
-(ChessColor)winnerInTable:(ChessTable*)table;

@end
