//
//  StandGameIcon.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandGameIcon : UIView{
    UIImageView* _thumbnail;
    UILabel* _chessName;
    NSString* _chessBundleName;
    NSString* _desc;
    BOOL _locked;
}

@property (nonatomic, retain) IBOutlet UIImageView* thumbnail;
@property (nonatomic, retain) IBOutlet UILabel* chessName;
@property (nonatomic, retain) NSString* chessBundleName;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, assign) BOOL locked;

-(void)setupGameIcon:(NSDictionary*)icon;
-(IBAction)iconIsClicked:(id)sender;

@end
