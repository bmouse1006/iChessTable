//
//  Chess.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessRules.h"

@class ChessTable;
@class ChessPiece;

@interface Chess : NSObject{
    NSString* _name; 
    ChessTable* _table;    
    NSDictionary* _pieces; //key is ChessColor, instance of NSString. Value is NSDictionary, which store names of piece and according number
    id<ChessRules> _rules;
    
    NSDictionary* _pieceModel;
}

@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) ChessTable* table;
@property (retain, nonatomic) NSDictionary* pieces;
@property (retain, nonatomic) id<ChessRules> rules;
@property (nonatomic, retain) NSDictionary* pieceModel;

+(Chess*)chessWithBundleFile:(NSString*)filePath;
+(Chess*)chessWithPropertyList:(NSDictionary*)plist;

@end
