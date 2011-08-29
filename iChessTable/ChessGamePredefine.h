//
//  ChessGamePredefine.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef iChessTable_ChessGamePredefine_h
#define iChessTable_ChessGamePredefine_h

#define MAX_LENGTH_OF_TABLE 60

typedef enum {
    ChessGameModeOnePlayer = 1, //Single player
    ChessGameModeTwoPlayers,    //Two players face to face
    ChessGameModeBlueTooth,     //Two players via blue tooth
    ChessGameModeGameCenter     //Two players view Game Center
} ChessGameMode;

#endif
