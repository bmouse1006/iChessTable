//
//  ChessViewControllerDelegate.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChessPieceView, ChessTableView;

@protocol ChessViewControllerDelegate <NSObject>

-(void)pieceViewIsSelected:(ChessPieceView*)pieceView;
-(void)pieceViewIsDropped:(ChessPieceView*)pieceView;
-(void)pieceViewIsMoving:(ChessPieceView*)pieceView;
-(void)pieceViewTouchingIsCancelled:(ChessPieceView*)pieceView;
-(BOOL)doesPieceViewCanBeMoved:(ChessPieceView*)pieceView;
-(void)tableView:(ChessTableView*)tableView isTouchedAt:(CGPoint)location;

@end
