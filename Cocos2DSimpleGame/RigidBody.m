#import "RigidBody.h"

@implementation RigidBody

@synthesize hasGravity;
@synthesize mass;
@synthesize momentOfInertia;
@synthesize friction;
@synthesize centerOfMass;
@synthesize position;
@synthesize lastPosition;
@synthesize velocity;
@synthesize acceleration;
@synthesize drag;
@synthesize rotation;
@synthesize lastRotation;
@synthesize rotationalVelocity;
@synthesize rotationalAcceleration;
@synthesize rotationalDrag;
@synthesize elasticity;
@synthesize points;
@synthesize previousPoints;
@synthesize boundBox;
@synthesize lastIntersection;
@synthesize lastTile;

-(id)init
{
    if (self = [super init])
    {
        self.hasGravity = YES;
        self.mass = 100.0f;
        self.momentOfInertia = 0;
        self.friction = 0;
        self.centerOfMass = [[Vector2 alloc] init];
        self.position = [[Vector2 alloc] init];
        self.lastPosition = [[Vector2 alloc] init];
        self.velocity = [[Vector2 alloc] init];
        self.acceleration = [[Vector2 alloc] init];
        self.drag = 0;
        self.rotation = 0;
        self.lastRotation = 0;
        self.rotationalVelocity = 0;
        self.rotationalAcceleration = 0;
        self.rotationalDrag = 0;
        self.elasticity = 0.60f;
        
        self.points = [[NSMutableArray alloc] init];
        self.previousPoints = [[NSMutableArray alloc] init];
        self.boundBox = [[NSMutableArray alloc] init];
        self.lastIntersection = [[NSMutableArray alloc] init];
        self.lastTile = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(id)initWithBoundingBox:(NSArray*)boundingBox
             andPosition:(Vector2*)pos
{
    [self init];
    
    self.points = [[NSMutableArray alloc] initWithCapacity:[boundingBox count]];
    self.previousPoints = [[NSMutableArray alloc] initWithCapacity:[boundingBox count]];
    self.boundBox = [[NSMutableArray alloc] initWithCapacity:[boundingBox count]];
    self.lastIntersection = [[NSMutableArray alloc] initWithCapacity:[boundingBox count]];
    self.lastTile = [[NSMutableArray alloc] initWithCapacity:[boundingBox count]];
    
    for(int i = 0; i < [boundingBox count]; i++)
    {
        // These are dummy points so the array is filled out to the right size
        [self.lastIntersection addObject:[[Vector2 alloc] initWithX:-1 andY:-1]];
        [self.lastTile addObject:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:-1 andY:-1] withWall:nil]];
    }
    
    self.position.x = pos.x;
    self.position.y = pos.y;
    [boundBox addObjectsFromArray:boundingBox];
    [self updatePoints];
    [self updatePoints]; // the second time fills in previousPoints
    [self calculateMomentOfInertia];
    
    return self;
    
}

-(void) updatePoints
{
    [self.points removeAllObjects];
    
	for(int i = 0; i < [self.boundBox count]; i++)
	{
        Vector2* point = [boundBox objectAtIndex:i];
        point = [point vectorByRotationInDegrees:rotation];
        point = [point vectorByAddingVector:position];
        
        [points addObject:point];
	}
}

-(void) storePreviousPoints
{
    [self.previousPoints removeAllObjects];
    [self.previousPoints addObjectsFromArray:points];
}

-(BOOL)containsPoint:(Vector2*)point
{
	// TODO: this will likely need to be adjusted
	if([position distanceToVector:point] > 100)
    {
		return false;
    }
    
	for(int i = 0; i < [points count]; i++)
	{
		Vector2* side;
		Vector2* pointVector;
        
		if(i == ([points count] - 1))
        {
			side = [(Vector2*)[points objectAtIndex:0] vectorBySubtractingVector:[points objectAtIndex:i]];
        }
		else
        {
            side = [(Vector2*)[points objectAtIndex:(i + 1)] vectorBySubtractingVector:[points objectAtIndex:i]];
        }
        
		pointVector = [point vectorBySubtractingVector:[points objectAtIndex:i]];
        
		if(![side isInteriorToVector:pointVector])
        {
			return NO;
        }
	}
    
	return YES;
}

-(void)calculateMomentOfInertia
{
    double sumNumerator = 0;
    double sumDenominator = 0;
    
    for(int i = 0; i < ([self.boundBox count] - 1); i++)
    {
        Vector2* pointA = [self.boundBox objectAtIndex:i];
        Vector2* pointB = [self.boundBox objectAtIndex:i + 1];
        
        double a = (pow(pointA.x, 2) + 
                    pow(pointA.y, 2) + 
                    (pointA.x * pointB.x) +
                    (pointA.y * pointB.y) +
                    pow(pointB.x, 2) +
                    pow(pointB.y, 2));
        
        double b = ((pointA.x * pointB.y) -
                    (pointB.x * pointA.y));
        
        sumNumerator += (a * b);
        sumDenominator += b;
    }
    
    self.momentOfInertia = (sumNumerator / sumDenominator) * (self.mass / 6);
    NSLog(@"Moment of Inertia: %f", self.momentOfInertia);
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"RigidBody: position - %f,%f  points - %d  previousPoints - %d", self.position.x, self.position.y, [self.points count], [self.previousPoints count]];
}

@end
