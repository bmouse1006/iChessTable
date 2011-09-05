//
//  ChessTable.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTable.h"
#import "ChessMatrix.h"
#import "ChessStep.h"

@implementation ChessTable

@synthesize bkImageName = _bkImageName;
@synthesize width = _width;
@synthesize height = _height;
@synthesize matrix = _matrix;
@synthesize historySteps = _historySteps;
@synthesize redoSteps = _redoSteps;
@synthesize movedInThisRound = _movedInThisRound;

#pragma getter and setter
-(NSString*)getBkImageName{
    //add more code in the furute for different devices - iPhone and iPad
    return _bkImageName;
}

-(NSEnumerator*)enumeratorOfPiecesInTable{
    return [self.matrix.pieceSet objectEnumerator];
}

#pragma class method
+(ChessTable*)chessTableWithPropertyList:(NSDictionary*)list{
    ChessTable* table = nil;
    @try {
        table = [[[ChessTable alloc] init] autorelease];
        table.bkImageName = [list valueForKey:@"bkImageName"];
        table.matrix.horiNodes = [(NSNumber*)[list valueForKey:@"horiNodes"] intValue];
        table.matrix.vertNodes = [(NSNumber*)[list valueForKey:@"vertNodes"] intValue];
        table.width = [(NSNumber*)[list valueForKey:@"width"] floatValue];
        table.height = [(NSNumber*)[list valueForKey:@"height"] floatValue];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        table = nil;
    }
    @finally {
    }
    
    return table;
}

#pragma instance method
-(void)performStep:(ChessStep*)step saveStep:(BOOL)save{
    //add more code here
    NSEnumerator* enumerator = [step singleStepEnumerator];
    ChessSingleStep* single = nil;
    [self beginUpdate];
    while (single = [enumerator nextObject]){
        switch (single.type) {
            case ChessSingleStepTypeAdd:
                [self addPiece:single.piece 
                            at:single.to];
                break;
            case ChessSingleStepTypeMove:
                [self movePiece:single.piece
                           from:single.from
                             to:single.to];
                break;
            case ChessSingleStepTypeDelete:
                [self removePiece:single.piece
                               at:single.to];
            default:
                break;
        }
        [self postNotificaiton:NOTIFICATION_TABLE_UPDATE_STEP withObj:single];
    }
    [self endUpdate];
    //save the step
    if (save){
        [self.historySteps addObject:step];
    }
    //after 
}

-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to{
    [self.matrix movePiece:piece from:from to:to];
}

-(void)addPiece:(ChessPiece*)piece at:(MatrixPoint*)point{
    [self.matrix addPiece:piece to:point];
}

-(void)removePiece:(ChessPiece*)piece at:(MatrixPoint*)point{
    [self.matrix removePiece:piece from:point];
}

-(void)beginUpdate{
    [self postNotificaiton:NOTIFICATION_TABLE_UPDATE_BEGIN withObj:nil];
}

-(void)endUpdate{
    [self postNotificaiton:NOTIFICATION_TABLE_UPDATE_END withObj:nil];
}

-(void)postNotificaiton:(NSString*)name withObj:(id)obj{
    NSDictionary* userInfo = (obj)?[NSDictionary dictionaryWithObject:obj forKey:@"obj"]:nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:name 
                                                        object:self
                                                      userInfo:userInfo];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        ChessMatrix* matrix = [[ChessMatrix alloc] init];
        self.matrix = matrix;
        [matrix release];
        self.historySteps = [NSMutableArray arrayWithCapacity:0];
        self.redoSteps = [NSMutableArray arrayWithCapacity:0];
    }
    
    return self;
}

-(void)dealloc{
    self.bkImageName = nil;
    self.matrix = nil;
    self.historySteps = nil;
    self.redoSteps = nil;
    self.movedInThisRound = nil;
    [super dealloc];
}

@end
