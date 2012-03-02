//
//  Map.h
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "LineSegment.h"
#import "Vector2.h"

#define BOTTOM -99999

@interface Map : NSObject

//void init(char* mapFile);
-(NSArray*)getTilesCrossedByLineSegment:(LineSegment*)lineSegment;

-(Tile*)getTileAdjacentToTile:(Tile*)tile 
              withSharedPoint:(Vector2*)sharedPoint;

-(Tile*)getTileAtPoint:(Vector2*)point;
-(NSArray*)getTilesBelowPoint:(Vector2*)point;
-(BOOL)isPointInBounds:(Vector2*)point;
-(void)sortTiles;

-(BOOL)tileSet:(NSArray*)tileSet
  containsTile:(Tile*)tile;

-(void)addTile:(Tile*)tile
     toTileSet:(NSMutableArray*)tileSet;

-(void)addTile:(Tile*)tile;

@property (nonatomic, retain) NSMutableArray* tiles;

@end
