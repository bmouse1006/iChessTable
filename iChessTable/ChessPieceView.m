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

- (id)initWithChessPiece:(ChessPiece*)piece
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.image = [UIImage imageNamed:piece.imageName];
    }
    
    return self;
}

@end
