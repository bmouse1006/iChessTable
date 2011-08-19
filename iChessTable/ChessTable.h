//
//  ChessTable.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChessMatrix;
@class ChessStep;

@interface ChessTable : NSObject{
    //back ground image for chess table
    NSString* _bkImage;
    //matrix for all points and pieces in the table
    ChessMatrix* _matrix;
    
    //all the steps that players performed
    NSMutableArray* _historySteps;
    //temperary stores steps that players undoed for redo operation
    //it will be empty as soon as any step performed by player
    NSMutableArray* _redoSteps;
}

@property (nonatomic, retain) NSString* bkImage;
@property (nonatomic, retain) ChessMatrix* matrix;
@property (nonatomic, retain) NSMutableArray* historySteps;
@property (nonatomic, retain) NSMutableArray* redoSteps;

//get a new chess table from property list
+(ChessTable*)chessTableWithPropertyList:(NSDictionary*)list;

//perform all steps that from judge or other sources
-(void)performStep:(ChessStep*)step;

@end
