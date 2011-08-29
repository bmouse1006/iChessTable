//
//  ChessPieceView.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessViewControllerDelegate.h"

@class ChessPiece;

@interface ChessPieceView : UIImageView{
    ChessPiece* _piece;
    id<ChessViewControllerDelegate> _delegate;
    
    BOOL _isMoving;
}

@property (nonatomic, retain) ChessPiece* piece;
@property (nonatomic, assign) id<ChessViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL isMoving;

-(id)initWithChessPiece:(ChessPiece*)piece;

-(void)moveByDeltaPoint:(CGPoint)delta;
-(void)moveTo:(CGPoint)to;

@end
