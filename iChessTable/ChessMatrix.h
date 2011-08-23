//
//  ChessMatrix.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChessPiece;

@interface MatrixPoint : NSObject {
    int _x;
    int _y;
}

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;

+(MatrixPoint*)pointWithX:(int)x andY:(int)y;

-(void)offTable;
-(BOOL)isOffTable;

@end

#define MAX_LENGTH_OF_TABLE 40

@interface ChessMatrix : NSObject{
    //matrix that stores all piece status
    ChessPiece* _matrix[MAX_LENGTH_OF_TABLE][MAX_LENGTH_OF_TABLE];
    
    //a set to retain all pieces that in the matrix
    NSMutableSet* _pieceSet;
    //a set to retain all removed piece
    NSMutableSet* _removedPieces;
    
    //size of the matrix
    int _horiNodes;
    int _vertNodes;
}

@property (nonatomic, assign) int horiNodes;
@property (nonatomic, assign) int vertNodes;
@property (nonatomic, retain) NSMutableSet* pieceSet;
@property (nonatomic, retain) NSMutableSet* removedPieces;

//add a new piece to point
-(void)addPiece:(ChessPiece*)piece to:(MatrixPoint*)location;
//remove piece piece from location
-(void)removePiece:(ChessPiece*)piece from:(MatrixPoint*)location;
//move an existing piece from point to another point
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromPoint to:(MatrixPoint*)toPoint;

//get piece at given location
-(ChessPiece*)pieceAtLocation:(MatrixPoint*)location;
//get location of given piece
-(MatrixPoint*)locationOfPiece:(ChessPiece*)piece;
//check if the location is in the scope
-(BOOL)isLocationInTheMatrix:(MatrixPoint*)point;

@end
