//
//  ChessPieceView.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessPieceView.h"
#import "ChessPiece.h"

@implementation ChessPieceView

@synthesize piece = _piece;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithChessPiece:(ChessPiece*)piece{
    self = [super initWithImage:[UIImage imageNamed:piece.imageName]];
    if (self){
        self.piece = piece;
    }
    
    return self;
}

-(void)dealloc{
    self.piece = nil;
    [super dealloc];
}

@end
