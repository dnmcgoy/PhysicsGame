#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

@synthesize rigidBody;
@synthesize player;
@synthesize map;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
        self.player = [CCSprite spriteWithFile:@"Player.png" 
                                          rect:CGRectMake(0, 0, 27, 40)];
        
        [self addChild:self.player];
        NSMutableArray* boundingBox = [[NSMutableArray alloc] init];
        [boundingBox addObject:[[Vector2 alloc] initWithX:-25 andY:-30]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:0 andY:25]];
        [boundingBox addObject:[[Vector2 alloc] initWithX:25 andY:-25]];
        self.rigidBody = [[RigidBody alloc] initWithBoundingBox:boundingBox
                                andPosition:[[Vector2 alloc] initWithX:220
                                                                  andY:200]];
        [self.rigidBody updatePoints];
        [self.rigidBody storePreviousPoints];
        self.rigidBody.velocity.x = 50;
        self.rigidBody.velocity.y = 50;
        self.player.position = ccp(self.rigidBody.position.x, self.rigidBody.position.y);
        
        self.map = [[Map alloc] init];
        
        Wall* bottomWall = [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:0 andY:1] andPointB:[[Vector2 alloc] initWithX:1 andY:1]];
        Wall* rightWall =  [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:0 andY:0] andPointB:[[Vector2 alloc] initWithX:0 andY:1]];
        Wall* topWall =    [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:1 andY:0] andPointB:[[Vector2 alloc] initWithX:0 andY:0]];
        Wall* leftWall =   [[Wall alloc] initWithPointA:[[Vector2 alloc] initWithX:1 andY:1] andPointB:[[Vector2 alloc] initWithX:1 andY:0]];
        
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:1 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:2 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:3 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:4 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:5 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:6 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:7 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:8 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:9 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:10 andY:0] withWall:bottomWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:1] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:2] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:3] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:4] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:5] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:11 andY:6] withWall:rightWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:10 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:9 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:8 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:7 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:6 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:5 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:4 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:3 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:2 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:1 andY:7] withWall:topWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:6] withWall:leftWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:5] withWall:leftWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:4] withWall:leftWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:3] withWall:leftWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:2] withWall:leftWall]];
        [self.map addTile:[[Tile alloc] initAtPosition:[[Vector2 alloc] initWithX:0 andY:1] withWall:leftWall]];
    }
    
    [self schedule:@selector(gameLoop:) interval:0.01666667];
    self.isTouchEnabled = YES;
    
    return self;
}

-(void)gameLoop:(ccTime)dt 
{
    [self updatePhysics: dt];
}

-(void)updatePhysics:(ccTime)dt
{
    [self.rigidBody storePreviousPoints];
    
    Vector2* myPoint = [self.rigidBody.previousPoints objectAtIndex:2];
    
    [Physics updateGravityOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics updateVelocityOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics updatePositionOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics updateRotationOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics correctCollisionsBetweenMap:self.map andRigidBody:self.rigidBody overTimeDelta:dt];
    [self.rigidBody updatePoints];
    
    myPoint = [self.rigidBody.previousPoints objectAtIndex:2];
}

-(void)draw
{
    self.player.position = ccp(self.rigidBody.position.x, self.rigidBody.position.y);
    [self drawRigidBodies];
    [self drawMap];
}

-(void)drawRigidBodies
{
    for(int i = 0; i < [self.rigidBody.points count]; i++)
	{
        Vector2* pointA = [self.rigidBody.points objectAtIndex:i];
        Vector2* pointB = nil;
        
		if(i < [self.rigidBody.points count] - 1)
		{
			pointB = [self.rigidBody.points objectAtIndex:i + 1];
		}
		else 
		{
            pointB = [self.rigidBody.points objectAtIndex:0];
		}
        
        glColor4f(1.0, 0.0, 0.0, 1.0);
        glLineWidth(1.0f);
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
}

-(void)drawMap
{
    for(int i = 0; i < [self.map.tiles count]; i++)
    {
        Tile* tile = [self.map.tiles objectAtIndex:i];
        Wall* absoluteWall = [tile getWallWithAbsolutePosition];
        Vector2* pointA = absoluteWall.w1;
        Vector2* pointB = absoluteWall.w2;
        
        glColor4f(0.0, 1.0, 0.0, 1.0);
        glLineWidth(1.0f);
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
}

-(void)dealloc
{
	[super dealloc];
}

@end
