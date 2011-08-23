//
//  ChessTableView.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTableView.h"
#import "ChessPieceView.h"
#import "ChessPiece.h"
#import "ChessTable.h"
#import "ChessMatrix.h"

@implementation ChessTableView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithChessTable:(ChessTable*)table{
    self = [super initWithImage:[UIImage imageNamed:table.bkImageName]];
    if (self){
        //caculate the table rect

    }
    
    return self;
}

@end
