//
//  ControlPanelWidget.m
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ControlPanelWidget.h"

@implementation ControlPanelWidget

@synthesize presentImageView = _presentImageView;
@synthesize enable = _enable;
@synthesize notificationName = _notificationName;

-(void)setEnable:(BOOL)enable{
    _enable = enable;
    //add more code here
    //change the appearence if needed
    /*
    switch(_enable){
        case YES:
            break;
        case NO:
            break;
     }
     */
}

-(void)dealloc{
    self.presentImageView = nil;
    self.notificationName = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    
}

//touches moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

}

//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

//touches cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end
