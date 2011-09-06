//
//  StandGameIcon.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "StandGameIcon.h"

@implementation StandGameIcon

@synthesize thumbnail = _thumbnail;
@synthesize chessName = _chessName;
@synthesize chessBundleName = _chessBundleName;
@synthesize desc = _desc;
@synthesize locked = _locked;

-(void)dealloc{
    self.thumbnail = nil;
    self.chessName = nil;
    self.chessBundleName = nil;
    self.desc = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //setup shadow
        
    }
    return self;
}

-(IBAction)iconIsClicked:(id)sender{
    DebugLog(@"icon is clicked", nil);
    DebugLog(@"Bunlde name is %@", self.chessBundleName);
    //send a notification to main screen to pop up a game controller view
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:self.chessBundleName forKey:@"chessBundleName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STARTUP_NEWGAME
                                                        object:nil
                                                      userInfo:userInfo];
}

-(void)setupGameIcon:(NSDictionary*)icon{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[icon objectForKey:@"thumbnail"]]];
    self.thumbnail = imageView;
    [imageView release];
    self.chessBundleName = [icon objectForKey:@"chessBundleName"];
    self.desc = [icon objectForKey:@"desc"];
    self.chessName.text = [icon objectForKey:@"name"];
    self.locked = [(NSNumber*)[icon objectForKey:@"locked"] boolValue];
    
    self.layer.shadowOffset = CGSizeMake(5, 3);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.6f;
    self.layer.cornerRadius = 10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
