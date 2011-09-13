//
//  GameViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessPiece.h"

@class ChessTableViewController, ChessPieceView, PlayerControlPanelView, ChessGameController, PlayerControlPanelController;

@interface GameViewController : UIViewController{
    ChessGameController* _game;
    ChessTableViewController* _tableViewController;
    PlayerControlPanelController* _panelControllerRight;
    PlayerControlPanelController* _panelControllerLeft;
    //containers for player control panel view
    UIView* _controlPanelLeftContainer;
    UIView* _controlPanelRightContainer;
    UIView* _chessTableViewContainer;
    
    ChessPieceColor _choosenColor;
}

@property (nonatomic, retain) ChessGameController* game;
@property (nonatomic, retain) ChessTableViewController* tableViewController;
@property (nonatomic, retain) PlayerControlPanelController* panelControllerRight;
@property (nonatomic, retain) PlayerControlPanelController* panelControllerLeft;
@property (nonatomic, retain) IBOutlet UIView* controlPanelLeftContainer;
@property (nonatomic, retain) IBOutlet UIView* controlPanelRightContainer;
@property (nonatomic, retain) IBOutlet UIView* chessTableViewContainer;
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

//set shadow and round corner for view
-(void)shadowAndRoundCorner:(UIView*)view;

@end
