//
//  Map.m
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Map.h"

@implementation Map

@synthesize tiles;

-(id)init
{
    if (self = [super init])
    {
        self.tiles = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)addTile:(Tile*)tile
{
    [self.tiles addObject:tile];
    [self sortTiles];
}

-(void)sortTiles
{
    self.tiles = [[self.tiles sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

-(BOOL)tileSet:(NSArray*)tileSet
  containsTile:(Tile*)tile
{
    if(tile == nil)
    {
        return NO;
    }
    
    NSEnumerator* tileEnumerator = [tileSet objectEnumerator];
    Tile* otherTile;
    
    while(otherTile = [tileEnumerator nextObject]) 
    {
        NSComparisonResult result = [tile compare:otherTile];
        
        if(result == NSOrderedSame)
        {
            return YES;
        }
    }
    
	return NO;
}

-(void)addTile:(Tile*)tile
     toTileSet:(NSMutableArray*)tileSet
{
    if(tile != nil && 
       tileSet != nil && 
       ![self tileSet:tileSet containsTile:tile])
    {
        [tileSet addObject:tile];
    }
}

-(NSArray*)getTilesCrossedByLineSegment:(LineSegment*)lineSegment
{
	// Add a tile to the result whenever 
	// we find the line segment has crossed a tile boundary
	// at a multiple of TILE_SIZE
    
	NSMutableArray* crossedTiles = [[NSMutableArray alloc] init];
    
	Vector2* v1 = lineSegment.v1;
	Vector2* v2 = lineSegment.v2;
	double xmin = MIN(v1.x, v2.x);
	double xmax = MAX(v1.x, v2.x);
	double ymin = MIN(v1.y, v2.y);
	double ymax = MAX(v1.y, v2.y);
    
	double mod = fmod(xmin, TILE_SIZE);
	double rmod = TILE_SIZE - mod;
	double curX, curY;
	curX = xmin + rmod;
	mod = fmod(ymin, TILE_SIZE);
	rmod = TILE_SIZE - mod;
	curY = ymin + rmod;
	
	while(curX < xmax)
	{
		Tile* tile = [self getTileAtPoint:[[Vector2 alloc] initWithX:curX - EPSILON 
                                                                andY:[lineSegment getYValueFromX:curX]]];
        [self addTile:tile toTileSet:crossedTiles];
                
        tile = [self getTileAtPoint:[[Vector2 alloc] initWithX:curX + EPSILON 
                                                          andY:[lineSegment getYValueFromX:curX]]];        
        [self addTile:tile toTileSet:crossedTiles];
        
		curX += TILE_SIZE;
	}
	
	while(curY < ymax)
	{
        Tile* tile = [self getTileAtPoint:[[Vector2 alloc] initWithX:curY - EPSILON 
                                                                andY:[lineSegment getXValueFromY:curY]]];
        [self addTile:tile toTileSet:crossedTiles];
        
		tile = [self getTileAtPoint:[[Vector2 alloc] initWithX:curY + EPSILON 
                                                          andY:[lineSegment getXValueFromY:curY]]];        
        [self addTile:tile toTileSet:crossedTiles];
        
        curY += TILE_SIZE;
	}
	
	Tile* tile = [self getTileAtPoint:v1];
	[self addTile:tile toTileSet:crossedTiles];
	tile = [self getTileAtPoint:v2];
	[self addTile:tile toTileSet:crossedTiles];
	
	return crossedTiles;
}

-(Tile*)getTileAdjacentToTile:(Tile*)tile
              withSharedPoint:(Vector2*)sharedPoint
{
	double x = tile.position.x;
	double y = tile.position.y;
    
	for(int i = -TILE_SIZE; i <= TILE_SIZE; i += TILE_SIZE)
    {
		for(int j = -TILE_SIZE; j <= TILE_SIZE; j += TILE_SIZE)
		{
			if(i == 0 && j == 0)
            {
				continue;
            }
            
			Tile* curTile = [self getTileAtPoint:[[Vector2 alloc] initWithX:x + i 
                                                                       andY:y + j]];
			
			if(curTile == nil || [curTile compare:tile] == NSOrderedSame)
            {
				continue;
            }
            
            Wall* absoluteWall = [curTile getWallWithAbsolutePosition];
            
			if((absoluteWall.w1.x == sharedPoint.x && absoluteWall.w1.y == sharedPoint.y)
               || (absoluteWall.w2.x == sharedPoint.x && absoluteWall.w2.y == sharedPoint.y))
            {
				return curTile;
            }
		}
    }
    
	return nil;
}

-(Tile*)getTileAtPoint:(Vector2*)point
{
	// We do this because negative zero is not useful to us
	if(point.x < 0) 
    {
        point.x -= TILE_SIZE;
    }
    
	if(point.y < 0) 
    {
        point.y -= TILE_SIZE;
    }
    
	long tileX = point.x / TILE_SIZE;
	long tileY = point.y / TILE_SIZE;
    Vector2* tilePosition = [[Vector2 alloc] initWithX:tileX andY:tileY];
    Vector2* zero = [[Vector2 alloc] initWithX:0 andY:0];
    Wall* zeroWall = [[Wall alloc] initWithPointA:zero
                                        andPointB:zero];

    Tile* findMe = [[Tile alloc] initAtPosition:tilePosition
                                       withWall:zeroWall];
    
	long low = 0;
	long high = [self.tiles count] - 1;
	long middle = 0;
	
	while(low != high)
	{
		middle = (low + high) / 2;
		Tile* tile = [self.tiles objectAtIndex:middle];
		
		if([tile compare:findMe] == NSOrderedAscending)
		{
			if(low == middle)
            {
				break;
            }
            
			low = middle;
		}
		else if([tile compare:findMe] == NSOrderedDescending)
		{
			if(high == middle)
            {
				break;
            }
            
			high = middle;
		}
		else
        {
            return tile;
        }
	}	
    
	// After the loop breaks there is still the possibility that it is at high or low
	// because of rounding when casting to long
	if([(Tile*)[self.tiles objectAtIndex:low] compare:findMe] == NSOrderedSame)
    {
		return [self.tiles objectAtIndex:low];
    }
	else if([(Tile*)[self.tiles objectAtIndex:high] compare:findMe] == NSOrderedSame)
    {
		return [self.tiles objectAtIndex:high];
    }
	else
    {
        return nil;
    }
}

// Returns all tiles that are at or below the given location.
// This is used for collision detection in which we will trace
// a line straight down to the axis and see how many times
// it crosses a wall.
-(NSArray*)getTilesBelowPoint:(Vector2 *)point
{
	NSMutableArray* tilesBelow = [[NSMutableArray alloc] init];
	double x = point.x;
	double y = point.y + TILE_SIZE; // Adding TILE_SIZE to be inclusive
    
    if(x < 0) 
    {
        x -= TILE_SIZE;
    }
    
	if(y < 0) 
    {
        y -= TILE_SIZE;
    }
    
	long tileX = x / TILE_SIZE;
	long tileY = y / TILE_SIZE;
    Vector2* tilePosition = [[Vector2 alloc] initWithX:tileX andY:tileY];
    Vector2* zero = [[Vector2 alloc] initWithX:0 andY:0];
    Wall* zeroWall = [[Wall alloc] initWithPointA:zero
                                        andPointB:zero];
    
    Tile* findMe = [[Tile alloc] initAtPosition:tilePosition
                                       withWall:zeroWall];
    
	long low = 0;
	long high = [self.tiles count] - 1;
	long middle = 0;
	
	while(low != high)
	{
		middle = (low + high) / 2;
		Tile* tile = [self.tiles objectAtIndex:middle];
		
		if([tile compare:findMe] == NSOrderedAscending)
		{
			if(low == middle)
            {
				break;
            }
            
			low = middle;
		}
		else if([tile compare:findMe] == NSOrderedDescending)
		{
			if(high == middle)
            {
				break;
            }
            
			high = middle;
		}
		else
        {
            break;
        }
	}
    
    int index = 0;
    
    if([(Tile*)[self.tiles objectAtIndex:middle] compare:findMe] == NSOrderedSame)
    {
		index = middle;
    }
	else if([(Tile*)[self.tiles objectAtIndex:high] compare:findMe] == NSOrderedSame)
    {
		index = high;
    }
	else
    {
        index = low;
    }
    
	Tile* tile = [self.tiles objectAtIndex:index];
    
	while(tile.position.x == tileX * TILE_SIZE)
	{
		[tilesBelow addObject:tile];
		index--;
        
		if(index < 0)
        {
            break;
        }
        
		tile = [self.tiles objectAtIndex:index];
	}
    
	return tilesBelow;
}

-(BOOL)isPointInBounds:(Vector2*)point
{
    // Draw a line straight down from the given point and count the number of
    // walls it intersects. If the number is odd, the point is in bounds.
    
	NSArray* tilesBelow = [self getTilesBelowPoint:point];
	Vector2* shadow = [[Vector2 alloc] initWithX:point.x andY:BOTTOM];
	LineSegment* vertical = [[LineSegment alloc] initWithVectorA:point andB:shadow];

    NSEnumerator* tileEnumerator = [tilesBelow objectEnumerator];
    Tile* tile;
    int intersections = 0;
    
    while(tile = [tileEnumerator nextObject]) 
    {
        Wall* absoluteWall = [tile getWallWithAbsolutePosition];
        
        LineSegment* wallSegment = [[LineSegment alloc] initWithVectorA: absoluteWall.w1 
                                                                   andB:absoluteWall.w2];
        
		if([vertical intersectsLineSegmentInclusive:wallSegment])
		{
			intersections++;
		}
    }

	return intersections % 2 == 1;
}

@end
