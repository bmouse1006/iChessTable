//
//  ControlPanelWidget.m
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ControlPanelWidget.h"

@implementation ControlPanelWidget

@synthesize type = _type;
@synthesize presentView = _presentView;
@synthesize primaryImageView = _primaryImageView;
@synthesize secondaryImageView = _secondaryImageView;
@synthesize animationImageView = _animationImageView;
@synthesize enable = _enable;
@synthesize humanOnly = _humanOnly;
@synthesize target = _target;
@synthesize action = _action;

-(void)setPrimaryImageView:(UIImageView *)primaryImageView{
    if (_primaryImageView != primaryImageView){
        [_primaryImageView release];
        _primaryImageView = primaryImageView;
        [_primaryImageView retain];
        [self shadowView:_primaryImageView shadow:YES];
    }
}

-(void)setSecondaryImageView:(UIImageView *)secondaryImageView{
    if (_secondaryImageView != secondaryImageView){
        [_secondaryImageView release];
        _secondaryImageView = secondaryImageView;
        [_secondaryImageView retain];
        [self shadowView:_secondaryImageView shadow:YES];
    }
}

-(void)setAnimationImageView:(UIImageView *)animationImageView{
    if (_animationImageView != animationImageView){
        [_animationImageView release];
        _animationImageView = animationImageView;
        [_animationImageView retain];
        [self shadowView:_animationImageView shadow:YES];
    }
}

-(void)setPresentView:(UIView *)presentView{
    if (_presentView != presentView){
        [_presentView removeFromSuperview];
        [_presentView release];
        _presentView = presentView;
        [_presentView retain];
        [self addSubview:_presentView];
    }
}

-(UIView*)getPresentView{
    if (_presentView == nil){
        self.presentView = self.primaryImageView;
    }
    
    return _presentView;
}

-(void)dealloc{
    self.type = nil;
    self.presentView = nil;
    self.primaryImageView = nil;
    self.secondaryImageView = nil;
    self.animationImageView = nil;
    [super dealloc];
}

-(id)initWithPropertiesList:(NSDictionary *)plist target:(id)target action:(SEL)action{
    self = [super init];
    if (self){
        self.target = target;
        self.action = action;
        float width = [(NSNumber*)[plist objectForKey:@"width"] floatValue];
        float height = [(NSNumber*)[plist objectForKey:@"height"] floatValue];
        [self setFrame:CGRectMake(0, 0, width, height)];
        self.enable = [(NSNumber*)[plist objectForKey:@"enable"] boolValue];
        self.humanOnly = [(NSNumber*)[plist objectForKey:@"humanOnly"] boolValue];
        self.type = [plist objectForKey:@"type"];
        UIImageView* imageView = nil;
        NSString* imageName = [plist objectForKey:@"primaryImage"];
        if (imageName != nil){
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            self.primaryImageView = imageView;
            [imageView release];
        }
        
        imageName = [plist objectForKey:@"secondaryImage"];
        if (imageName != nil){
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            self.secondaryImageView = imageView;
            [imageView release];
        }
        
        imageName = [plist objectForKey:@"animationImage"];
        if (imageName != nil){
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            self.animationImageView = imageView;
            [imageView release];
        }
        
        self.presentView = self.primaryImageView;
        [self addSubview:self.presentView];
    }
    
    return self;
}

-(id)initWithImage:(UIImage*)image 
    secondaryImage:(UIImage*)secondaryImage 
    animationImage:(UIImage*)animationImage
            target:(id)target 
            action:(SEL)action{
    self = [super init];
    if (self){
        UIImageView* imageView = nil;
        
        if (image != nil){
            imageView = [[UIImageView alloc] initWithImage:image];
            self.primaryImageView = imageView;
            [imageView release];
        }
        
        if (secondaryImage != nil){
            imageView = [[UIImageView alloc] initWithImage:secondaryImage];
            self.secondaryImageView = imageView;
            [imageView release];
        }
        
        if (animationImage != nil){
            imageView = [[UIImageView alloc] initWithImage:animationImage];
            self.animationImageView = imageView;
            [imageView release];
        }
        
        self.presentView = self.primaryImageView;
        
        self.target = target;
        self.action = action;
        //default is enabled
        //no multi touch support
        self.multipleTouchEnabled = NO;
        self.userInteractionEnabled = YES;
        [self touchedDown:NO];
    }
    
    return self;
}

-(id)init{
    self = [super init];
    if (self){
        self.enable = YES;
        self.humanOnly = NO;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.enable = YES;
        self.humanOnly = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//touch began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //widget is touched
    //appearence should be changed
    if (self.enable){
        [self touchedDown:YES];
    }
}

//touches moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.enable){
        UITouch* touch = [[touches objectEnumerator] nextObject];
        if (CGRectContainsPoint(self.frame, [touch locationInView:self.superview])){
            //show touched down view
            [self touchedDown:YES];
        }else{
            //show normal view
            [self touchedDown:NO];
        }
    }
}

//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.enable){
        //if this touch is in the scope of widget and the widget is enabled
        //send out message: [target action]
        UITouch* touch = [[touches objectEnumerator] nextObject];
        if (CGRectContainsPoint(self.frame, [touch locationInView:self.superview])){
            [self.target performSelector:self.action withObject:self];
        }
        //back to normal
        [self touchedDown:NO];
    }
}

//touches cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //back to normal
    if (self.enable){
        [self touchedDown:NO];
    }
}

-(void)touchedDown:(BOOL)down{
    [self addSubview:self.presentView];
    if (down){
        CGRect frame = self.presentView.frame;
        frame.origin.x = 3;
        frame.origin.y = 3;
        BOOL temp = self.enable;
//        self.enable = NO;
        //disable this widget during the animation
        //restore the status after animation is complete
        [UIView animateWithDuration:0.1
                         animations:^{
                             [self.presentView setFrame:frame];
                             [self shadowView:self.presentView shadow:NO];
        } 
                         completion:^(BOOL finished){self.enable = temp;}];
        
        
    }else{   
        CGRect frame = self.presentView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        BOOL temp = self.enable;
//        self.enable = NO;
        //disable this widget during the animation
        //restore the status after animation is complete
        [UIView animateWithDuration:0.1
                         animations:^{
                             [self.presentView setFrame:frame];
                             [self shadowView:self.presentView shadow:YES];
        } 
                         completion:^(BOOL finished){self.enable = temp;}];
    }
}

-(void)playAnimation{
    //play the preloaded animation image view
}

-(void)shadowView:(UIView*)view shadow:(BOOL)shadow{
    if (shadow){
        view.layer.shadowOffset = CGSizeMake(3, 3);
    }else{
        view.layer.shadowOffset = CGSizeMake(0, 0);
    }
    view.layer.shadowOpacity = 0.6;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
}

-(void)presentThisView:(UIView *)view{
    if (self.presentView != view){
        [self.presentView removeFromSuperview];
        self.presentView = view;
        [self addSubview:self.presentView];
        [self bringSubviewToFront:self.presentView];
    }
}

@end
