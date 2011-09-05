//
//  StandTableViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StandTableViewController.h"
#import "StandTableViewCell.h"
#import "StandGameIcon.h"

#define CHESSLISTNAME @"ChessList"
#define CHESSNUMINONEROW 3

@implementation StandTableViewController

@synthesize tableView = _tableView;
@synthesize chessList = _chessList;
@synthesize tempCell = _tempCell;
@synthesize tempIcon = _tempIcon;

-(void)dealloc{
    self.tableView = nil;
    self.chessList = nil;
    self.tempCell = nil;
    self.tempIcon = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"StandTableViewCell" owner:self options:nil];
    self.tableView.rowHeight = self.tempCell.frame.size.height;
    self.tempCell = nil;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //4 chesses for one row
    int rowCount = [self.chessList count]/CHESSNUMINONEROW + 1;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StandTableCell";
    
    StandTableViewCell* cell = (StandTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"StandTableViewCell" owner:self options:nil];
        cell = self.tempCell;
        self.tempCell = nil;
    }
    NSInteger start = indexPath.row*CHESSNUMINONEROW;
    NSInteger end = ((start+CHESSNUMINONEROW)>[self.chessList count])?([self.chessList count]):(start+CHESSNUMINONEROW);
    for(int i = start; i<end; i++){
        [[NSBundle mainBundle] loadNibNamed:@"StandGameIcon" owner:self options:nil];           
        [self.tempIcon setupGameIcon:[self.chessList objectForKey:[_chessListKeys objectAtIndex:i]]];
        [cell addAnIcon:self.tempIcon];
        self.tempIcon = nil;
    }
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

-(NSDictionary*)getChessList{
    if (_chessList == nil){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:CHESSLISTNAME ofType:@"plist"];
        DebugLog(@"path is %@", filePath);
        self.chessList = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return _chessList;
}
                         
 -(void)setChessList:(NSDictionary *)chessList{
     if (_chessList != chessList){
         [_chessList release];
         [_chessListKeys release];
         _chessList = nil;
         _chessList = chessList;
         [_chessList retain];
         _chessListKeys = [_chessList keysSortedByValueUsingComparator:^(id dic1, id dic2) {
             NSString* index1 = [dic1 objectForKey:@"index"];
             NSString* index2 = [dic2 objectForKey:@"index"];
             return [index1 compare:index2];
         }];
         [_chessListKeys retain];
     }
 }

@end
