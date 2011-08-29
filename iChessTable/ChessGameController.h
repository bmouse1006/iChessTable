//
//  ChessGameController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chess, ChessJudge, ChessPlayer;

@interface ChessGameController : NSObject{
    Chess* _chess;
    ChessJudge* _judge;
    ChessPlayer* _playerAI;
    ChessGameMode _mode;
}

@property (nonatomic, retain) Chess* chess;
@property (nonatomic, retain) ChessJudge* judge;
@property (nonatomic, retain) ChessPlayer* playerAI;
@property (nonatomic, assign) ChessGameMode mode;

//create a new game controller via chess bundle name
+(ChessGameController*)gameControllerWithChessBundleName:(NSString*)name;

-(void)registerNotifications;
-(void)unregisterNotifications;


@end
