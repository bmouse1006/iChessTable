//
//  Chess.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Chess.h"
#import "ChessTable.h"
#import <Foundation/NSObjCRuntime.h>

@implementation Chess

@synthesize name = _name;
@synthesize table = _table;
@synthesize pieces = _pieces;
@synthesize rules = _rules;
@synthesize pieceModel = _pieceModel;

+(Chess*)chessWithBundleFile:(NSString*)filePath{
    
    NSDictionary* bundle = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    return [self chessWithPropertyList:bundle];

}

+(Chess*)chessWithPropertyList:(NSDictionary*)plist{
    Chess* newChess = nil;
    @try {
        newChess = [[[Chess alloc] init] autorelease];
        newChess.name = [plist valueForKey:@"name"];
        newChess.pieces = [plist valueForKey:@"pieces"];
        newChess.rules = [[[NSClassFromString([plist valueForKey:@"rules"]) alloc] init] autorelease];
        newChess.table = [ChessTable chessTableWithPropertyList:[plist valueForKey:@"table"]];
        newChess.pieceModel = [plist valueForKey:@"pieceModel"];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        newChess = nil;
    }
    @finally {
    }
    
    return newChess;
}

//init and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.name = nil;
    self.table = nil;
    self.pieces = nil;
    self.rules = nil;
    self.pieceModel = nil;
    [super dealloc];
}

@end
