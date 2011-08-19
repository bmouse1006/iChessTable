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
    int _height;
    int _width;
}

@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;
@property (nonatomic, retain) NSMutableSet* pieceSet;
@property (nonatomic, retain) NSMutableSet* removedPieces;

//add a new piece to point
-(void)setPiece:(ChessPiece*)piece at:(MatrixPoint*)location;
//remove piece piece from location
-(void)removePieceFrom:(MatrixPoint*)location;
//move an existing piece from point to another point
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromPoint to:(MatrixPoint*)toPoint;

//get piece at given location
-(ChessPiece*)pieceAtLocation:(MatrixPoint*)location;
//get location of given piece
-(MatrixPoint*)locationOfPiece:(ChessPiece*)piece;
//check if the location is in the scope
-(BOOL)isLocationInTheMatrix:(MatrixPoint*)point;

@end
