//
//  ChessPlayer.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessPlayer.h"

@implementation ChessPlayer

@synthesize type = _type;
@synthesize color = _color;

+(ChessPlayer*)playerWithColor:(ChessPieceColor)color andType:(ChessPlayerType)type{
    ChessPlayer* player = [[ChessPlayer alloc] init];
    player.color = color;
    player.type = type;
    return [player autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)play{
    switch (self.type) {
        case ChessPlayerTypeAI:
            //send notification saying that it's AI's turn now
            //
            break;
        case ChessPlayerTypePeople:
            //send notification saying that I'm going to start play
            break;
        case ChessPlayerTypeBlueTooth:
            //not support in this version
            break;
        case ChessPlayerTypeGameCenter:
            //not support in this version
            break;
        default:
            break;
    }
}

@end
