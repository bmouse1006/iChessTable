//
//  iChessTableViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iChessTableViewController.h"
#import "GameStandViewController.h"
#import "HistoryViewController.h"

@implementation iChessTableViewController

@synthesize gameStandController = _gameStandController;
@synthesize historyViewController = _historyViewController;
@synthesize standContainer = _standContainer;
@synthesize historyContainer = _historyContainer;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc{
    self.gameStandController = nil;
    self.historyViewController = nil;
    self.standContainer = nil;
    self.historyContainer = nil;
    [super dealloc];
}
#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self.standContainer addSubview:self.gameStandController.view];
    [self.historyContainer addSubview:self.historyViewController.view];
    CGRect stand = self.gameStandController.view.frame;
    CGRect history = self.historyViewController.view.frame;
    stand.origin.y = 0;
    history.origin.y = 0;
    [self.gameStandController.view setFrame:stand];
    [self.historyViewController.view setFrame:history];
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
