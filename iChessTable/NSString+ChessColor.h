//
//  NSString+ChessColor.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPiece.h"

#define CHESSBLACKCOLOR @"chessBlackColor"
#define CHESSWHITECOLOR @"chessWhiteColor"
#define CHESSNONECOLOR @"chessNoneColor"

@interface NSString (NSString_ChessColor)

+(NSString*)chessColorString:(ChessColor)color;

@end
