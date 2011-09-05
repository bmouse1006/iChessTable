//
//  ChessPieceView.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessViewControllerDelegate.h"
#import "MultiTouchImageView.h"

@class ChessPiece;

@interface ChessPieceView : MultiTouchImageView{
    ChessPiece* _piece;
    id<ChessViewControllerDelegate> _delegate;
    
    BOOL _isMoving;
    BOOL _selected;
}

@property (nonatomic, retain) ChessPiece* piece;
@property (nonatomic, assign) id<ChessViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, assign, setter = setSelected:) BOOL selected;

-(id)initWithChessPiece:(ChessPiece*)piece;

-(void)moveTo:(CGPoint)to;
-(void)moveBack;
//fix location of the view
-(void)fix;

-(BOOL)touchesInScope:(NSSet*)touches;

@end
