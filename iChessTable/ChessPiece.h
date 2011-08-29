//
//  ChessPiece.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MatrixPoint;

typedef enum {
    ChessNoneColor = 0,
    ChessBlackColor,
    ChessWhiteColor
} ChessColor;

@interface ChessPiece : NSObject{
    NSString* _name;
    NSString* _chessName;
    MatrixPoint* _origin;
    ChessColor _color;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* chessName;
@property (nonatomic, assign) ChessColor color;
@property (nonatomic, retain) MatrixPoint* origin;
@property (nonatomic, readonly, getter = getImageName) NSString* imageName;//combined by chessname+name+color

//generate a new chess by given property list
//returns nil if any exception happens
+(ChessPiece*)chessPieceWithProperyList:(NSDictionary*)plist andColor:(ChessColor)color; 

@end
