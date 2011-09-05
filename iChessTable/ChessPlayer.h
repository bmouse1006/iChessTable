//
//  ChessPlayer.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPiece.h"

typedef enum{
    ChessPlayerTypePeople,
    ChessPlayerTypeAI,
    ChessPlayerTypeBlueTooth,
    ChessPlayerTypeGameCenter
} ChessPlayerType;

@interface ChessPlayer : NSObject{
    ChessPieceColor _color;
    ChessPlayerType _type;
}

@property (nonatomic, assign) ChessPieceColor color;
@property (nonatomic, assign) ChessPlayerType type;

+(ChessPlayer*)playerWithColor:(ChessPieceColor)color andType:(ChessPlayerType)type;

//tell the player go head to play
-(void)play;

@end
