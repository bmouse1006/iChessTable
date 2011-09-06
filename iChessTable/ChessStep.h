//
//  ChessStep.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MatrixPoint, ChessPiece;

typedef enum {
    ChessSingleStepTypeDelete,
    ChessSingleStepTypeMove,
    ChessSingleStepTypeAdd,
} ChessSingleStepType;

@interface ChessSingleStep : NSObject {
    ChessSingleStepType _type;
    ChessPiece* _piece;
    MatrixPoint* _from;//this only works while type is move
    MatrixPoint* _to;
}

@property (nonatomic, assign) ChessSingleStepType type;
@property (nonatomic, retain) ChessPiece* piece;
@property (nonatomic, retain) MatrixPoint* from;
@property (nonatomic, retain) MatrixPoint* to;

//reversed single step
-(ChessSingleStep*)reverse;

@end

@interface ChessStep : NSObject{
    NSMutableArray* _singleSteps;
}

@property (nonatomic, retain) NSMutableArray* singleSteps;
//provide a reveresed Chess Step
-(ChessStep*)reverse;
-(void)addPiece:(ChessPiece*)piece at:(MatrixPoint*)location;
-(void)removePiece:(ChessPiece*)piece at:(MatrixPoint*)location;
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromLocation to:(MatrixPoint*)toLocation;

-(NSEnumerator*)singleStepEnumerator;
//sort single steps
//priority:
//1. remove
//2. move
//3. add
-(void)sortSingleSteps;

@end
