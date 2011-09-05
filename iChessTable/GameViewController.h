//
//  GameViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessPiece.h"

@class ChessTableViewController, ChessPieceView, PlayerControlPanelView, ChessGameController;

@interface GameViewController : UIViewController{
    ChessGameController* _game;
    ChessTableViewController* _tableViewController;
}

@property (nonatomic, retain) ChessGameController* game;
@property (nonatomic, retain) ChessTableViewController* tableViewController;
//panel view here

-(id)initWithChessGameName:(NSString*)name mode:(ChessGameMode)mode choosenColor:(ChessPieceColor)color;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil 
             gameName:(NSString*)name 
                 mode:(ChessGameMode)mode 
         choosenColor:(ChessPieceColor)color;

-(void)composeSubViews;
-(void)composePlayerControlPanelViews;
-(void)composeChessTableViews;//table and pieces are all included

//register and unregister all notifications
-(void)registerNotifications;
-(void)unregisterNotifications;

@end
