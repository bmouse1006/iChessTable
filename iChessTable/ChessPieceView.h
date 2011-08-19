//
//  ChessPieceView.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChessPiece;

@interface ChessPieceView : UIImageView{
}

- (id)initWithChessPiece:(ChessPiece*)piece;

@end
