//
//  ChessRules.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChessTable, ChessPoint, ChessStep, Chess;

@protocol ChessRules <NSObject>

@required

//reset the game table to the original status
-(void)resetChessTable:(Chess*)chess;
//check if dropping in the table is legal or not
-(BOOL)isDroppingLegal:(ChessPoint*)point inTable:(ChessTable*)table;
//check if the moving in table is legal or not
-(BOOL)isMovingLegal:(NSArray*)pointArray inTable:(ChessTable*)table;
//generate a step for dropping in the table. This instance of step will be passed to table to move/add/delete piece
-(ChessStep*)generateStepForDropping:(ChessPoint*)point inTable:(ChessTable*)table;
-(ChessStep*)generateStepForMoving:(NSArray*)pointArray inTable:(ChessTable*)table;
//check if the player is winner
-(BOOL)doesCurrentPlayerWin:(ChessTable*)table color:(NSString*)color;

@end
