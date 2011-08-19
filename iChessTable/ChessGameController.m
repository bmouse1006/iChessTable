//
//  ChessGameController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessGameController.h"

@implementation ChessGameController

@synthesize chess = _chess;
@synthesize judge = _judge;
@synthesize playerAI = _playerAI;
@synthesize viewController = _viewController;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.chess = nil;
    self.judge = nil;
    self.playerAI = nil;
    self.viewController = nil;
    [super dealloc];
}

@end
