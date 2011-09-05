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
#import "GameViewController.h"

@implementation iChessTableViewController

@synthesize gameStandController = _gameStandController;
@synthesize historyViewController = _historyViewController;
@synthesize gameViewController = _gameViewController;
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
    self.gameViewController = nil;
    self.standContainer = nil;
    self.historyContainer = nil;
    [super dealloc];
}
#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.standContainer addSubview:self.gameStandController.view];
    [self.historyContainer addSubview:self.historyViewController.view];
    CGRect stand = self.gameStandController.view.frame;
    CGRect history = self.historyViewController.view.frame;
    stand.origin.y = 0;
    history.origin.y = 0;
    [self.gameStandController.view setFrame:stand];
    [self.historyViewController.view setFrame:history];
    [self registerNotifications];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self unregisterNotifications];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

//present a new game view after reveiving new game start up notification
-(void)notificationStartUpNewGame:(NSNotification*)notification{
    NSString* bundleName = [notification.userInfo objectForKey:@"chessBundleName"];
    DebugLog(@"new game start up notification is received", nil);
    DebugLog(@"bundle name is %@", bundleName);
    GameViewController* newGame = [[GameViewController alloc] initWithChessGameName:bundleName 
                                                                               mode:ChessGameModeTwoPlayers 
                                                                       choosenColor:ChessMaxColor];
    self.gameViewController = newGame;
    [newGame release];
    
//    [self.view addSubview:self.gameViewController.view];
//    [self.view bringSubviewToFront:self.gameViewController.view];
//    [UIView transitionWithView:self.view
//                      duration:0.2
//                       options:UIViewAnimationOptionShowHideTransitionViews
//                    animations:^{[self.view addSubview:self.gameViewController.view]; }
//                    completion:NULL];
//    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.gameViewController
                            animated:YES];
}

-(void)registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(notificationStartUpNewGame:)
                                                 name:NOTIFICATION_STARTUP_NEWGAME
                                               object:nil];
}

-(void)unregisterNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
