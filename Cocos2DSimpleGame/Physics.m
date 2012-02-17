#import "Physics.h"

@implementation Physics

+(void)correctCollisionsBetweenMap:(Map*)map
                      andRigidBody:(RigidBody*)rigidBody
                     overTimeDelta:(double)timeDelta
{
	Collision* collision = [self getCollisionWhereRigidBody:rigidBody
                                        isInsideOfWallOnMap:map
                                              overTimeDelta:timeDelta];
    
    [self applyCollision:collision
             toRigidBody:rigidBody 
           overTimeDelta:timeDelta];
	
	for(int i = -TILE_SIZE; i <= TILE_SIZE; i += TILE_SIZE)
    {
		for(int j = -TILE_SIZE; j <= TILE_SIZE; j += TILE_SIZE)
		{
			Tile* tile = [map getTileAtPoint:[[Vector2 alloc] initWithX:rigidBody.position.x + i 
                                                                   andY:rigidBody.position.y + j]];
            
			if(tile == nil)
            {
				continue;
            }
            
            collision = [self getCollisionWhereWallFromTile:tile
                                        isInsideOfRigidBody:rigidBody
                                              overTimeDelta:timeDelta];
            
            /*for(int i = 0; i < [collision.collisions count]; i++)
            {
                Vector2* intersection = [collision.collisions objectAtIndex:i];
                NSLog(@"intersection: %f, %f", intersection.x, intersection.y);
                
                Vector2* normal = [collision.normals objectAtIndex:i];
                NSLog(@"normal: %f, %f", normal.x, normal.y);
                
                Vector2* correction = [collision.corrections objectAtIndex:i];
                NSLog(@"correction: %f, %f", correction.x, correction.y);
            }*/
            
			//[self applyCollision:collision toRigidBody:rigidBody overTimeDelta:timeDelta];
		}
    }
}

+(Collision*)getCollisionWhereRigidBody:(RigidBody*)rigidBody
                    isInsideOfWallOnMap:(Map*)map
                          overTimeDelta:(double)timeDelta
{
    Collision* collision = [[Collision alloc] init];
    
	// cycle through bounding box points
	for(int i = 0; i < [rigidBody.points count]; i++)
	{
		// if the point is out of bounds, get the point at which it went out of bounds
		LineSegment* path = [[LineSegment alloc] initWithVectorA:[rigidBody.points objectAtIndex:i] 
                                                            andB:[rigidBody.previousPoints objectAtIndex:i]];
		NSArray* tiles = [map getTilesCrossedByLineSegment:path];
		Vector2* intersection = nil;
		
		for(int j = 0; j < [tiles count]; j++)
		{
            Tile* tile = [tiles objectAtIndex:j];
            Wall* absoluteWall = [tile getWallWithAbsolutePosition];
			
            LineSegment* wall = [[LineSegment alloc] initWithVectorA:absoluteWall.w1
                                                                andB:absoluteWall.w2];
            
            intersection = [wall pointByIntersectionWithLineSegment:path];
            
            //NSLog(@"wall: %f,%f %f,%f", wall.v1.x, wall.v1.y, wall.v2.x, wall.v2.y);
            //NSLog(@"path: %f,%f %f,%f", path.v1.x, path.v1.y, path.v2.x, path.v2.y);
            
            if(intersection)
			{
				[rigidBody.lastTile replaceObjectAtIndex:i 
                                              withObject:[tiles objectAtIndex:j]];
                
				[rigidBody.lastIntersection replaceObjectAtIndex:i 
                                                      withObject:intersection];
                
				break;
			}
		}
        
        /*if(!intersection && ![map isPointInBounds:[rigidBody.points objectAtIndex:i]])
        {
            NSLog(@"crap . . .");
        }*/
        
        /*if(!intersection)
        {
            continue;
        }*/
        
		// check if the point is out of bounds
		if([map isPointInBounds:[rigidBody.points objectAtIndex:i]])
        {
            continue;
        }
        
        Vector2* lastIntersection = [rigidBody.lastIntersection objectAtIndex:i];
        
        if(lastIntersection.x == -1 && lastIntersection.y == -1)
        {
            continue;
        }
		
		// project the point onto the wall
		Tile* tile = [rigidBody.lastTile objectAtIndex:i];
		Wall* absoluteWall = [tile getWallWithAbsolutePosition];
        Vector2* wall = [absoluteWall.w2 vectorBySubtractingVector:absoluteWall.w1];
        
		LineSegment* wallSegment = [[LineSegment alloc] initWithVectorA:absoluteWall.w1 
                                                                   andB:absoluteWall.w2];
        
        Vector2* rigidBodyPoint = [rigidBody.points objectAtIndex:i];
		Vector2* caster = [rigidBodyPoint vectorBySubtractingVector:absoluteWall.w1];
		Vector2* projection = [wall vectorByProjectionOntoThisVector:caster];
		Vector2* correction = [projection vectorBySubtractingVector:caster];
        
        // projected point is on the line, but not the segment
		// so we need to project it again onto the neighboring wall
		if(![wallSegment intersectsPoint:[projection vectorByAddingVector:absoluteWall.w1]])
		{
			double d1 = [projection getLength];
			double d2 = [[[projection vectorByAddingVector:absoluteWall.w1] vectorBySubtractingVector:absoluteWall.w2] getLength];
			Vector2* closestWallPoint = (d1 < d2) ? absoluteWall.w1 : absoluteWall.w2;
			projection = [[projection vectorByAddingVector:absoluteWall.w1] vectorBySubtractingVector:closestWallPoint];
            
			Tile* adjacent = [map getTileAdjacentToTile:tile 
                                        withSharedPoint:closestWallPoint];
            
			if(adjacent)
			{
				Vector2* neighborWall = [adjacent.wall.w1 vectorBySubtractingVector:adjacent.wall.w2];
				double angle = 0;
				
				if(d1 < d2)	
                {
                    angle = [wall angleInDegreesWithVector:neighborWall];
                }
				else
				{
					angle = [neighborWall angleInDegreesWithVector:wall];
					neighborWall = [adjacent.wall.w2 vectorBySubtractingVector:adjacent.wall.w1];
				}
				
				// if the angle between the walls is concave, but less than 90,
				// project the point onto the neighboring wall
				if(angle >= 90)
				{
					caster = projection;
					projection = [neighborWall vectorByProjectionOntoThisVector:caster];
					correction = [correction vectorByAddingVector: [projection vectorBySubtractingVector:caster]];
        		}
				// otherwise, try to move the point to the shared wall point
				else
                {
                    correction = [closestWallPoint vectorBySubtractingVector:[rigidBody.points objectAtIndex:i]];
                }
			}
		}
        
        if(intersection)
        {
            [collision.collisions addObject:intersection];
        }
        else
        {
            [collision.collisions addObject:[rigidBody.lastIntersection objectAtIndex:i]];
        }
        
		[collision.normals addObject:[wall vectorByNormalToThisVector]];
		[collision.corrections addObject:correction];
	}
    
    return collision;
}

+(Collision*)getCollisionWhereWallFromTile:(Tile*)tile
                       isInsideOfRigidBody:(RigidBody*)rigidBody
                             overTimeDelta:(double)timeDelta
{
    Collision* collision = [[Collision alloc] init];
    
	Wall* absoluteWall = [tile getWallWithAbsolutePosition];
    NSArray* wallPoints = [absoluteWall getPoints];
	NSEnumerator* wallEnumerator = [wallPoints objectEnumerator];
    Vector2* wallPoint;
    
    while (wallPoint = [wallEnumerator nextObject])
	{
		if(![rigidBody containsPoint:wallPoint])
		{	
            continue;
        }
        
		Vector2* direction = [rigidBody.position vectorBySubtractingVector:wallPoint];
		Line* path = [[Line alloc] initWithVectorA:[wallPoint vectorBySubtractingVector:direction]
                                              andB:wallPoint];
        
		for(int i = 0; i < [rigidBody.points count]; i++) // cycle through edges of r
		{
			LineSegment* side;
            
			if(i == ([rigidBody.points count] - 1))
            {
				side = [[LineSegment alloc] initWithVectorA:[rigidBody.points objectAtIndex:i]
                                                       andB:[rigidBody.points objectAtIndex:0]];
            }
			else 
            {    
                side = [[LineSegment alloc] initWithVectorA:[rigidBody.points objectAtIndex:i]
                                                       andB:[rigidBody.points objectAtIndex:(i + 1)]];
            }
            
			Vector3* side3D = [[Vector3 alloc] initWithX:(side.v2.x - side.v1.x)
                                                    andY:(side.v2.y - side.v1.y)
                                                    andZ:0];
                        
            Vector3* z = [[Vector3 alloc] initWithX:0 
                                               andY:0 
                                               andZ:1];
                        
            Vector3* n = [side3D vectorByCrossProductWithVector:z];
            
			Vector2* normal = [[Vector2 alloc] initWithX:n.x 
                                                    andY:n.y];
			
            normal = [normal vectorByNormalization];
            
			if(![side intersectsLine:path] || 
               [normal angleInDegreesWithVector:direction] >= 90 || 
               [normal angleInDegreesWithVector:direction] <= -90) // check if the path of an interior point crossed the current edge of rigidBody
            {
				continue;
            }
			
			Vector2* intersection = [side pointByIntersectionWithLine:path];
            [collision.collisions addObject:intersection];
            [collision.normals addObject:normal];
            [collision.corrections addObject:[wallPoint vectorBySubtractingVector:intersection]];
		}
	}
    
    return collision;
}

+(void)applyCollision:(Collision*)collision
          toRigidBody:(RigidBody*)rigidBody
        overTimeDelta:(double)timeDelta
{
	if(collision == nil || ![collision isValidCollision])
    {
        return;
    }
    
	Vector2* positionCorrection = [[Vector2 alloc] initWithX:0 andY:0];
	Vector2* velocityCorrection = [[Vector2 alloc] initWithX:0 andY:0];
	double rotationalVelocityCorrection = 0;
	
	for(int i = 0; i < [collision.collisions count]; i++)
	{		
		positionCorrection = [positionCorrection vectorByAddingVector: [collision.corrections objectAtIndex:i]];
        Vector2* collisionPoint = [collision.collisions objectAtIndex:i];
        Vector2* normal = [collision.normals objectAtIndex:i];
        
		VelocityPair* velocityPair = [self applyImpulseToRigidBody:rigidBody
                                                       atPoint:[[Vector3 alloc] initWithX:collisionPoint.x
                                                                                     andY:collisionPoint.y
                                                                                     andZ:0]
                                                    withNormal:[[Vector3 alloc] initWithX:normal.x 
                                                                                     andY:normal.y
                                                                                     andZ:0]];
		
        velocityCorrection = [velocityCorrection vectorByAddingVector:velocityPair.velocity];
		rotationalVelocityCorrection += velocityPair.rotationalVelocity;
	}
    
	positionCorrection = [positionCorrection vectorByDivision:[collision.collisions count]];
	velocityCorrection = [velocityCorrection vectorByDivision:[collision.collisions count]];
	rotationalVelocityCorrection /= [collision.collisions count];
    
    //NSLog(@"positionCorrection: %f, %f", positionCorrection.x, positionCorrection.y);
    //NSLog(@"count: %d", [collision.collisions count]);
    
    for(int i = 0; i < [rigidBody.points count]; i++)
    {
        Vector2* myPoint = [rigidBody.points objectAtIndex:i];
        //NSLog(@"before: %f, %f", myPoint.x, myPoint.y);
    }
    
    rigidBody.position = [rigidBody.position vectorByAddingVector:positionCorrection];
    rigidBody.velocity = [rigidBody.velocity vectorByAddingVector:velocityCorrection];
	rigidBody.rotationalVelocity += rotationalVelocityCorrection;
    
    Vector2* myPoint = [rigidBody.points objectAtIndex:2];
    [rigidBody updatePoints];
    
    for(int i = 0; i < [rigidBody.points count]; i++)
    {
        Vector2* myPoint = [rigidBody.points objectAtIndex:i];
        //NSLog(@"after: %f, %f", myPoint.x, myPoint.y);
    }
    
    myPoint = [rigidBody.points objectAtIndex:2];
}

// Body-to-wall reaction
+(void)applyCorrections:(NSArray*)corrections
            toRigidBody:(RigidBody*)rigidBody
          overTimeDelta:(double)timeDelta
{
	if([corrections count] == 0) 
    {
        return;
    }
	
	Vector2* positionCorrection = [[Vector2 alloc] initWithX:0 andY:0];
	
	for(int i = 0; i < [corrections count]; i++)
    {
		positionCorrection = [positionCorrection vectorByAddingVector:[corrections objectAtIndex:i]];
    }
    
	positionCorrection = [positionCorrection vectorByDivision:[corrections count]];
	
	rigidBody.position = [rigidBody.position vectorByAddingVector:positionCorrection];
	[rigidBody updatePoints];	
}

// Ship-to-wall impulse
+(VelocityPair*)applyImpulseToRigidBody:(RigidBody*)rigidBody
                                atPoint:(Vector3*)point
                             withNormal:(Vector3*)normal
{
	VelocityPair* result = [[VelocityPair alloc] init];
    
	double e = 1.0f;			
    
    // position
	Vector3* p = [rigidBody.position toVector3];

    // cOfM velocity
	Vector3* v_a1 = [rigidBody.velocity toVector3];	
	
    // angular velocity
    Vector3* omega_a1 = [[Vector3 alloc] initWithX:0
                                              andY:0
                                              andZ:(PI * rigidBody.rotationalVelocity / 180)];
    
    // vector from cOfM to collision point
	Vector3* r_ap = [point vectorBySubtractingVector:p]; 
    
    // velocity at collision point
    Vector3* v_ap1 = [v_a1 vectorByAddingVector:[omega_a1 vectorByCrossProductWithVector:r_ap]]; 
    
    Vector3* cross = [r_ap vectorByCrossProductWithVector:normal];
	
    double moment = rigidBody.mass * pow([r_ap getLength], 2) * 2; // moment of inertia
    double numerator = [[v_ap1 vectorByMultiplication:(-1 * (1 + e))] dotProductWithVector:normal];
    double denominator = 1;
    
    if(rigidBody.mass != 0)
    {
        denominator = (1 / rigidBody.mass) + ([cross dotProductWithVector:cross] / moment);
    }
    
    double impulse;
    
	if(denominator != 0)
    {
		impulse = numerator / denominator;
    }
	else
    {
        impulse = 0;
    }
    
    // new velocity
	Vector3* v_a2 = [[normal vectorByMultiplication:impulse] vectorByDivision:rigidBody.mass];
    
    // new angular velocity
	Vector3* omega_a2 = [[r_ap vectorByCrossProductWithVector: [normal vectorByMultiplication:impulse]] vectorByDivision:moment]; 
    
    result.velocity.x = v_a2.x;
	result.velocity.y = v_a2.y;
	result.rotationalVelocity = 180 * omega_a2.z / PI;
    
    return result;
}

+(void)updatePositionOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta
{
	rigidBody.position = [rigidBody.position vectorByAddingVector:[rigidBody.velocity vectorByMultiplication:timeDelta]];
    [rigidBody updatePoints];
}

+(void)updateVelocityOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta
{
    Vector2* dV = [rigidBody.acceleration vectorByMultiplication:timeDelta];
    rigidBody.velocity = [rigidBody.velocity vectorByAddingVector: dV];
}

+(void)updateRotationOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta
{
    rigidBody.lastRotation = rigidBody.rotation;
	rigidBody.rotation += rigidBody.rotationalVelocity * timeDelta;
	rigidBody.rotation = fmod(rigidBody.rotation + 360.0, 360.0);
	[rigidBody updatePoints];
}

+(void)updateRotationalVelocityOfRigidBody:(RigidBody*)rigidBody
                             overTimeDelta:(double)timeDelta
{
	rigidBody.rotationalVelocity = rigidBody.rotationalAcceleration * timeDelta;
}

+(void)updateGravityOfRigidBody:(RigidBody*)rigidBody
                  overTimeDelta:(double)timeDelta
{
	if(rigidBody.hasGravity)
    {
        rigidBody.acceleration.y = GRAVITY;
    }
}

+(void)updateDragOfRigidBody:(RigidBody*)rigidBody
               overTimeDelta:(double)timeDelta
{
	rigidBody.velocity = [rigidBody.velocity vectorByAddingVector:[rigidBody.velocity vectorByMultiplication:(rigidBody.drag * -1 * timeDelta)]];
	rigidBody.rotationalVelocity += rigidBody.rotationalVelocity * rigidBody.rotationalDrag * -1 * timeDelta;
}

@end
