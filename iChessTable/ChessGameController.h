//
//  ChessGameController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPiece.h"

@class Chess, ChessJudge, ChessPlayer;

@interface ChessGameController : NSObject{
    Chess* _chess;
    ChessJudge* _judge;
    ChessGameMode _mode;
    
    ChessPlayer* _players[ChessMaxColor];
}

@property (nonatomic, retain) Chess* chess;
@property (nonatomic, retain) ChessJudge* judge;
@property (nonatomic, assign) ChessGameMode mode;
@property (nonatomic, readonly, getter = getCurrentPlayer) ChessPlayer* currentPlayer;

//create a new game controller via chess bundle name
+(ChessGameController*)gameControllerWithChessBundleName:(NSString*)name mode:(ChessGameMode)mode choosenColor:(ChessPieceColor)color;

-(void)createPlayersInstanceByChoosenColor:(ChessPieceColor)color;

-(void)start;
//do some check and validate after player performed an action
-(void)afterAction;

-(void)registerNotifications;
-(void)unregisterNotifications;


@end
