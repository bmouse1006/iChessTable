//
//  ChessGameController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chess;
@class ChessJudge;
@class ChessPlayer;
@class ChessViewController;

@interface ChessGameController : NSObject{
    Chess* _chess;
    ChessJudge* _judge;
    ChessPlayer* _playerAI;
    
    ChessViewController* _viewController;
}

@property (nonatomic, retain) Chess* chess;
@property (nonatomic, retain) ChessJudge* judge;
@property (nonatomic, retain) ChessPlayer* playerAI;
@property (nonatomic, retain) ChessViewController* viewController;

@end
