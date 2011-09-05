//
//  ChessTable.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChessPiece, ChessMatrix, MatrixPoint, ChessStep;

@interface ChessTable : NSObject{
    //back ground image for chess table
    NSString* _bkImageName;
    //width and height of pieces grid
    float _width;
    float _height;
    //matrix for all points and pieces in the table
    ChessMatrix* _matrix;
    
    //all the steps that players performed
    NSMutableArray* _historySteps;
    //temperary stores steps that players undoed for redo operation
    //it will be empty as soon as any step performed by player
    NSMutableArray* _redoSteps;
    //View controller for chess table and all pieces
    ChessPiece* _movedInThisRound;
}

@property (nonatomic, retain, getter = getBkImageName) NSString* bkImageName;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, retain) ChessMatrix* matrix;
@property (nonatomic, retain) NSMutableArray* historySteps;
@property (nonatomic, retain) NSMutableArray* redoSteps;
@property (nonatomic, retain) ChessPiece* movedInThisRound;

//get a new chess table from property list
+(ChessTable*)chessTableWithPropertyList:(NSDictionary*)list;

//perform all steps that from judge or other sources
//and save this step if necessary
-(void)performStep:(ChessStep*)step saveStep:(BOOL)save;
//change the status of pieces and also change the views
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to;
-(void)addPiece:(ChessPiece*)piece at:(MatrixPoint*)point;
-(void)removePiece:(ChessPiece*)piece at:(MatrixPoint*)point;

//provide an enumerator for pieces that in the table
-(NSEnumerator*)enumeratorOfPiecesInTable;

//notify update status
-(void)beginUpdate;
-(void)endUpdate;
-(void)postNotificaiton:(NSString*)name withObj:(id)obj;

@end
