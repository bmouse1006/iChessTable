//
//  GameStandViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameStandViewController.h"
#import "StandTableViewController.h"

@implementation GameStandViewController

@synthesize standTableController = _standTableController;
@synthesize standTitleView = _standTitleView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    self.standTableController = nil;
    self.standTitleView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CGRect standTable = CGRectMake(0, self.standTitleView.frame.size.height, STANDTABLEWIDTH, STANDTABLEHEIGHT);
//    [self.standTableController.view setFrame:standTable];
    [self.view addSubview:self.standTableController.view];
    CGRect stand = self.standTableController.view.frame;
    stand.origin.y = self.standTitleView.frame.size.height;
    stand.size.width = self.standTitleView.frame.size.width;
    [self.standTableController.view setFrame:stand];
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
