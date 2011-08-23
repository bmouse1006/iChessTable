//
//  ChessGameController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessGameController.h"
#import "Chess.h"
#import "ChessJudge.h"
#import "ChessPlayer.h"

@implementation ChessGameController

@synthesize chess = _chess;
@synthesize judge = _judge;
@synthesize playerAI = _playerAI;
@synthesize mode = _mode;

//factory method
+(ChessGameController*)gameControllerWithChessBundleName:(NSString*)name{
    //generate a new game controller
    ChessGameController* gameController = [[ChessGameController alloc] init];
    //generate a chess instance with bundle name
    gameController.chess = [Chess chessWithBundleFile:name];
    //set rule to judge
    gameController.judge = [ChessJudge judgeWithRules:gameController.chess.rules];
    
    return [gameController autorelease];
}

#pragma Notification selectors
//notifications from view controller that initiated by players
//NOTIFICATION_PLAYER_PIECE_SELECT    
-(void)notificationPieceSelect:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_SELECT is received", nil);
    //get a notification from view controller that player has selected a piece
    //call judge to check if selecting is legal
    //post the result
    //if it's legal
    //update matrix
    //if it's illegal
    
}
//NOTIFICATION_PLAYER_PIECE_DROP
-(void)notificationPieceDrop:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_DROP is received", nil);
    //get a notification from view controller that player has just dropped a piece -- directly or end of dragging
    //call judge to check if dropping is legal
    //post the result
    //if it's legal
    //update matrix
    //if it's illegal
    
}
//NOTIFICATION_PLAYER_PIECE_MOVE
-(void)notificationPieceMove:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_MOVE is received", nil);
    //get a notification from view controller that player is moving a piece now
    //call judge to check if moving is legal
    //post the result
    //if it's legal
    //update matrix
    //if it's illegal
}
//NOTIFICATION_REPLAY_START
-(void)notificationReplayStart:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_REPLAY_START is received", nil);
    //get a notification from view controller that player is moving a piece now

}
//NOTIFICATION_REPLAY_END
-(void)notificationReplayEnd:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_REPLAY_END is received", nil);
    //get a notification from view controller that player is moving a piece now

}
//NOTIFICATION_REPLAY_PAUSE_RESUME
-(void)notificationReplayPauseResume:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_REPLAY_PAUSE_RESUME is received", nil);
    //get a notification from view controller that player is moving a piece now

}
//NOTIFICATION_REPLAY_FORWARD
-(void)notificationReplayForward:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_REPLAY_PAUSE_FORWARD is received", nil);
    //get a notification from view controller that player is moving a piece now

}
//NOTIFICATION_REPLAY_REWARD
-(void)notificationReplayReward:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_REPLAY_PAUSE_REWARD is received", nil);
    //get a notification from view controller that player is moving a piece now

}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        //register notification name
        [self registerNotifications];
    }
    
    return self;
}

-(void)dealloc{
    self.chess = nil;
    self.judge = nil;
    self.playerAI = nil;
    //unregister notification name
    [self unregisterNotifications];
    [super dealloc];
}

//register observer for all notifications
-(void)registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(notificationPieceSelect:) 
                                                 name:NOTIFICATION_PLAYER_PIECE_SELECT 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationPieceDrop:) 
                                                 name:NOTIFICATION_PLAYER_PIECE_DROP 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationPieceMove:) 
                                                 name:NOTIFICATION_PLAYER_PIECE_MOVE
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationRelayStart:) 
                                                 name:NOTIFICATION_REPLAY_START
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationRelayEnd:) 
                                                 name:NOTIFICAITON_REPLAY_END
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationRelayPauseResume:) 
                                                 name:NOTIFICATION_REPLAY_PAUSE_RESUME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationRelayForward:) 
                                                 name:NOTIFICATION_REPLAY_FORWARD
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationRelayReward:) 
                                                 name:NOTIFICATION_REPLAY_REWARD
                                               object:nil];
}

//remove observer for all notifications
-(void)unregisterNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_PLAYER_PIECE_SELECT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_PLAYER_PIECE_DROP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_PLAYER_PIECE_MOVE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_REPLAY_START object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICAITON_REPLAY_END object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_REPLAY_PAUSE_RESUME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_REPLAY_FORWARD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_REPLAY_REWARD object:nil];
}

@end
