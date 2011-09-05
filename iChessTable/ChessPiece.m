//
//  ChessPiece.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessPiece.h"
#import "ChessMatrix.h"
#import "NSString+ChessPieceColor.h"

@implementation ChessPiece

@synthesize chessName = _chessName;
@synthesize name = _name;
@synthesize color = _color;
@synthesize origin = _origin;

+(ChessPiece*)chessPieceWithProperyList:(NSDictionary*)plist andColor:(ChessPieceColor)color{
    ChessPiece* piece = nil;
    @try {
        piece = [[[ChessPiece alloc] init] autorelease];
        piece.color = color;
        piece.name = [plist valueForKey:@"name"];
        piece.chessName = [plist valueForKey:@"chessName"];
        piece.origin = [MatrixPoint pointWithX:-1 andY:-1];
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
    //format of name is self.chessName_self.name_colorstr
    NSString* name = [NSString stringWithFormat:@"%@_%@_%@", self.chessName, self.name, [NSString ChessPieceColorString:self.color]];
    //add more code in the future for different devices - iPhone and iPad
    return name;
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
    self.origin = nil;
    [super dealloc];
}

@end
