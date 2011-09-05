//
//  NSString+ChessPieceColor.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPiece.h"

#define CHESSBLACKCOLOR @"chessBlackColor"
#define CHESSWHITECOLOR @"chessWhiteColor"
#define CHESSMAXCOLOR @"ChessMaxColor"

@interface NSString (NSString_ChessPieceColor)

+(NSString*)ChessPieceColorString:(ChessPieceColor)color;

@end
