//
//  ChessPiece.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessPiece.h"

@implementation ChessPiece

@synthesize chessName = _chessName;
@synthesize name = _name;
@synthesize color = _color;

+(ChessPiece*)chessPieceWithProperyList:(NSDictionary*)plist andColor:(NSString *)color{
    ChessPiece* piece = nil;
    @try {
        piece = [[[ChessPiece alloc] init] autorelease];
        piece.color = color;
        piece.name = [plist valueForKey:@"name"];
        piece.chessName = [plist valueForKey:@"chessName"];
    }
    @catch (NSException *exception) {
        DebugLog(@"exp happened. reason is %@", exception.reason);
        piece = nil;
    }
    @finally {
        
    }
    
    return piece;
}

-(NSString*)getImageName{
    return [NSString stringWithFormat:@"%@_%@_%@", self.chessName, self.name, self.color];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.chessName = nil;
    self.name = nil;
    self.color = nil;
    [super dealloc];
}

@end
