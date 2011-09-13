//
//  ChessPieceView.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ChessPieceView.h"
#import "ChessPiece.h"

@implementation ChessPieceView

@synthesize piece = _piece;
@synthesize delegate = _delegate;
@synthesize isMoving = _isMoving;
@synthesize selected = _selected;

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
        self.userInteractionEnabled = YES;
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.selected = NO;
    }
    
    return self;
}

-(void)dealloc{
    self.piece = nil;
    [super dealloc];
}

-(void)moveTo:(CGPoint)to{
    DebugLog(@"to.x = %f", to.x);
    DebugLog(@"to.y = %f", to.y);
    [self fix];
    [self enableEffect];
    [UIView animateWithDuration:0.2 
                     animations:^{self.center = to;} 
                     completion:^(BOOL finished){[self setEffect];}];
}

-(void)moveBack{
    [self enableEffect];
    [UIView animateWithDuration:0.2 
                     animations:^{self.transform = CGAffineTransformIdentity;} 
                     completion:^(BOOL finished){[self setEffect];}];
    originalTransform = self.transform;
}

-(void)fix{
    self.center = CGPointApplyAffineTransform(self.center, self.transform);
    self.transform = CGAffineTransformIdentity;
    originalTransform = self.transform;
}

//response to touch event
//touches began
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    DebugLog(@"touch began for piece view", nil);
    [self.superview bringSubviewToFront:self];
    [self.delegate pieceViewIsSelected:self];
}

//touches moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //player is moving piece
//    DebugLog(@"touch moved for piece view", nil);
    if ([self.delegate doesPieceViewCanBeMoved:self]){
        [self.delegate pieceViewIsMoving:self];
        self.isMoving = YES;
        [super touchesMoved:touches withEvent:event];
    }
}

//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //player is end of touching
    //set isMoving = NO
    //if touch is out of scope for current view, do nothing
    if ([self touchesInScope:touches] == YES){
        [super touchesEnded:touches withEvent:event];
        DebugLog(@"touch ended for piece view", nil);
        [self.delegate pieceViewIsEndOfTouching:self];
        self.isMoving = NO;
    }
}

//touches cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"touch cancelled for piece view %@", self);
    [super touchesCancelled:touches withEvent:event];
    self.isMoving = NO;
    [self.delegate pieceViewTouchingIsCancelled:self];
}

-(BOOL)touchesInScope:(NSSet*)touches{
    NSArray* touchArray = [touches allObjects];
    UITouch* touch = [touchArray objectAtIndex:0];
    return CGRectContainsPoint(self.frame, [touch locationInView:self.superview]);
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    if (_selected == YES){
        //add visual effect
        [self enableEffect];
    }else{
        //remove visual effect
        [self disableEffect];
    }
}
     
 -(void)enableEffect{
     DebugLog(@"enable effect for piece view", nil);
     self.layer.shadowOffset = CGSizeMake(10, 6);
 }
 -(void)disableEffect{
     DebugLog(@"disable effect for piece view", nil);
     self.layer.shadowOffset = CGSizeMake(3, 2);
 }

-(void)setEffect{
    switch (self.selected) {
        case YES:
            [self enableEffect];
            break;
        case NO:
            [self disableEffect];
        default:
            break;
    }
}
@end
