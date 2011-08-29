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
@synthesize delegate = _delegate;
@synthesize isMoving = _isMoving;

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
        self.multipleTouchEnabled = NO;
    }
    
    return self;
}

-(void)dealloc{
    self.piece = nil;
    [super dealloc];
}

-(void)moveTo:(CGPoint)to{
    CGPoint delta = CGPointMake(to.x-self.center.x, to.y-self.center.y);
    [self moveByDeltaPoint:delta];
}

-(void)moveByDeltaPoint:(CGPoint)delta{
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, delta.x, delta.y);
    [UIView animateWithDuration:0.2 
                          delay:0 
                        options:UIViewAnimationCurveEaseIn
                     animations:^{[self setTransform:transform];}
                     completion:NULL];
}

//response to touch event
//touches began
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate pieceViewIsSelected:self];
}

//touches moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //player is moving piece
    if ([self.delegate doesPieceViewCanBeMoved:self]){
        [self.delegate pieceViewIsMoving:self];
        self.isMoving = YES;
        NSEnumerator* enumerator = [touches objectEnumerator];
        UITouch* touch = nil;
        while (touch = [enumerator nextObject]) {
            //only response to tap count == 1
            CGPoint previous, current;
            switch (touch.tapCount) {
                case 1:
                    previous = [touch previousLocationInView:self];
                    current = [touch locationInView:self];
                    [self moveByDeltaPoint:CGPointMake(current.x-previous.x, current.y-previous.y)];
                    break;
                default:
                    break;
            }
        }
        //
    }
}

//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //player is end of touching
    //set isMoving = NO
    self.isMoving = NO;
    [self.delegate pieceViewIsDropped:self];
}

//touches cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isMoving = NO;
    [self.delegate pieceViewTouchingIsCancelled:self];
}

@end
