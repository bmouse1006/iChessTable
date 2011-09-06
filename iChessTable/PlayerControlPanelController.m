//
//  PlayerControlPanelController.m
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayerControlPanelController.h"

@implementation PlayerControlPanelController

@synthesize player = _player;
@synthesize widgets = _widgets;

-(void)dealloc{
    self.player = nil;
    self.widgets = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)loadView{
    [super loadView];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 700)];
    view.backgroundColor = [UIColor clearColor];
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
