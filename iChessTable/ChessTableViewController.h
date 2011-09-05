//
//  ChessTableViewController.h
//  iChessTable
//  Controller for chess table view and all piece views
//  Responsable for add/remove/move piece views in chess table view
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessViewControllerDelegate.h"

@class ChessTable, ChessTableView, ChessPiece, ChessPieceView, MatrixPoint, ChessGameController;

@interface ChessTableViewController : UIViewController<ChessViewControllerDelegate>{
    
    ChessTable* _table;
    ChessGameController* _game;
    ChessTableView* _tableView;
    ChessPieceView* _pieceViewMatrix[MAX_LENGTH_OF_TABLE][MAX_LENGTH_OF_TABLE];
    
    ChessPieceView* _selectedPieceView;
}

@property (nonatomic, retain, setter = setTable:) ChessTable* table;
@property (nonatomic, retain) ChessGameController* game;
@property (nonatomic, retain) ChessTableView* tableView;
@property (nonatomic, retain, setter = setSelectedPieceView:) ChessPieceView* selectedPieceView;//only one selected piece view

+(id)tableViewControllerWithChessTable:(ChessTable*)table;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chessTable:(ChessTable*)table;

//get center point for the given piece
-(CGPoint)centerPointForPiece:(ChessPiece*)piece;

//piece view control
-(void)addPieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at;
-(void)removePieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at;
-(void)movePieceViewForPiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to;

//register/unregister notifications from game controller
-(void)registerNotifications:(id)object;
-(void)unregisterNotifications:(id)object;

//send out notifications
-(void)postNotificaiotnWithName:(NSString*)name piece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to;

@end
