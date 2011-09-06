//
//  HistoryViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "HistoryViewController.h"
#import "HistoryTableViewController.h"

@implementation HistoryViewController

@synthesize historyTableViewController = _historyTableController;
@synthesize historyTitleView = _historyTitleView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    self.historyTitleView = nil;
    self.historyTableViewController = nil;
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
    [self.view addSubview:self.historyTableViewController.view];
    CGRect history = self.historyTableViewController.view.frame;
    history.origin.y = self.historyTitleView.frame.size.height;
    [self.historyTableViewController.view setFrame:history];
    //set shadow for title view
//    self.historyTableViewController.view.layer.shadowOpacity = 0.6;
//    self.historyTableViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.historyTableViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
//    self.historyTableViewController.view.layer.shadowRadius = 40;
//    [self.view bringSubviewToFront:self.historyTableViewController.view];
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
