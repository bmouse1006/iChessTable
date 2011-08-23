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

@class ChessTable, ChessTableView, ChessPiece, ChessPieceView, MatrixPoint;

@interface ChessTableViewController : UIViewController{
    ChessTable* _table;
    ChessTableView* _tableView;
    float _gridNodeWidth;
    float _gridNodeHeight;
    //frame for the chess table, inside table view
    CGRect _tableRect;
}

@property (nonatomic, retain, setter = setTable:) ChessTable* table;
@property (nonatomic, retain) ChessTableView* tableView;
@property (nonatomic, assign) float gridNodeWidth;
@property (nonatomic, assign) float gridNodeHeight;
@property (nonatomic, assign) CGRect tableRect;

+(id)tableViewControllerWithChessTable:(ChessTable*)table;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chessTable:(ChessTable*)table;

-(CGPoint)centerPointForPiece:(ChessPiece*)piece;

//piece view control
-(void)addPieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at;
-(void)removePieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at;
-(void)movePieceViewForPiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to;

//register/unregister notifications from game controller
-(void)registerNotifications:(id)object;
-(void)unregisterNotifications:(id)object;

@end
