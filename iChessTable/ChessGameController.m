//
//  ChessGameController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessGameController.h"
#import "Chess.h"
#import "ChessPiece.h"
#import "ChessTable.h"
#import "ChessJudge.h"
#import "ChessPlayer.h"

@implementation ChessGameController

@synthesize chess = _chess;
@synthesize judge = _judge;
@synthesize mode = _mode;

//factory method
+(ChessGameController*)gameControllerWithChessBundleName:(NSString*)name 
                                                    mode:(ChessGameMode)mode 
                                            choosenColor:(ChessPieceColor)color{
    //generate a new game controller
    ChessGameController* gameController = [[ChessGameController alloc] init];
    //generate a chess instance with bundle name
    gameController.chess = [Chess chessWithBundleName:name];
    //set rule to judge
    gameController.judge = [ChessJudge judgeWithRules:gameController.chess.rules];
    gameController.mode = mode;
    
    [gameController createPlayersInstanceByChoosenColor:color];
    
    return [gameController autorelease];
}

-(void)createPlayersInstanceByChoosenColor:(ChessPieceColor)color{
    ChessPlayer* player1 = nil;
    ChessPlayer* player2 = nil;
    switch (self.mode) {
        case ChessGameModeBlueTooth:
            //not supported in this version
            break;
        case ChessGameModeOnePlayer:
            player1 = [ChessPlayer playerWithColor:color andType:ChessPlayerTypePeople];
            player2 = [ChessPlayer playerWithColor:(color == ChessBlackColor)?ChessWhiteColor:ChessBlackColor
                                           andType:ChessPlayerTypeAI];
            //set ai to player2
            //add more code here
            break;
        case ChessGameModeGameCenter:
            //not supported in this version
            break;
        case ChessGameModeTwoPlayers:
            player1 = [ChessPlayer playerWithColor:ChessBlackColor andType:ChessPlayerTypePeople];
            player2 = [ChessPlayer playerWithColor:ChessWhiteColor andType:ChessPlayerTypePeople];
            break;
        default:
            break;
    }
    [player1 retain];
    [player2 retain];
    _players[player1.color] = player1;
    _players[player2.color] = player2;
}

-(void)start{
    DebugLog(@"game is started", nil);
    //invoke judge to setup game table
    [self.judge resetTable:self.chess];
    //player for white color to play
    [self.currentPlayer play];
}

-(void)afterAction{
    //check if could continue play
    if ([self.judge couldContinuePlayInTable:self.chess.table]){
        return;
    }
    //get the winner
    ChessPieceColor winner = [self.judge winnerInTable:self.chess.table];
    if (winner != ChessMaxColor){//if someone is winner
        //send a notification to game view controller
        //to tell that someone is the winner
        //        [self postNotificationWithName:xxxxx];
    }else{
        //if no one is winner
        //1. switch player
        //2. player plays
        //empty moved piece in the last round
        self.chess.table.movedInThisRound = nil;
        [self.judge switchPlayer];
        [self.currentPlayer play];
    }
}

-(ChessPlayer*)getCurrentPlayer{
    return _players[self.judge.currentColor];
}

#pragma Notification selectors
//notifications from view controller that initiated by players
//NOTIFICATION_PLAYER_PIECE_SELECT    
-(void)notificationPieceSelect:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_SELECT is received", nil);
    //get a notification from view controller that player has selected a piece
    //All select is legal if this method is invoked, according to current logic
//    MatrixPoint* from = [notification.userInfo objectForKey:@"from"];
//    MatrixPoint* to = [notification.userInfo objectForKey:@"to"];
    //update matrix
    
}
//NOTIFICATION_PLAYER_PIECE_DROP
-(void)notificationPieceDrop:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_DROP is received", nil);
    //get a notification from view controller that player has just dropped a piece
//    ChessPiece* piece = [notification.userInfo objectForKey:@"piece"]; it's nil in drop event
//    MatrixPoint* from = [notification.userInfo objectForKey:@"from"]; it's nil in drop evetn
    MatrixPoint* to = [notification.userInfo objectForKey:@"to"];
    //drop a default kind of piece
    ChessPiece* piece = [self.chess getDefaultPieceByColor:self.judge.currentColor]; 
    //get all steps
    ChessStep* step = [self.judge stepForDropping:piece to:to inTable:self.chess.table];
    //perform the steps
    [self.chess.table performStep:step saveStep:YES];
    [self afterAction];
}
//NOTIFICATION_PLAYER_PIECE_MOVE
-(void)notificationPieceMove:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_PLAYER_PIECE_MOVE is received", nil);
    //get a notification from view controller that a piece is just moved 
    ChessPiece* piece = [notification.userInfo objectForKey:@"piece"];
    MatrixPoint* from = [notification.userInfo objectForKey:@"from"];
    MatrixPoint* to = [notification.userInfo objectForKey:@"to"];
    //get all steps
    ChessStep* step = [self.judge stepForMoving:piece from:from to:to inTable:self.chess.table];
    //perform the steps
    [self.chess.table performStep:step saveStep:YES];
    self.chess.table.movedInThisRound = piece;
    [self afterAction];
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
    for (int i = 0; i<ChessMaxColor; i++){
        [_players[i] release];
    }
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
