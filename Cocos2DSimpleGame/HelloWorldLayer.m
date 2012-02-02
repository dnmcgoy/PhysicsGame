#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

@synthesize rigidBody;
@synthesize player;

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
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        self.player = [CCSprite spriteWithFile:@"Player.png" 
                                          rect:CGRectMake(0, 0, 27, 40)];
        
        [self addChild:self.player];
		
        self.rigidBody = [[RigidBody alloc] init];
        
        self.rigidBody.position = [[Vector2 alloc] initWithX: winSize.width/2 + self.player.contentSize.width/2 
                                                        andY: winSize.height];
        
        self.player.position = ccp(self.rigidBody.position.x, self.rigidBody.position.y);
    }
    
    [self schedule:@selector(gameLoop:) interval:0.01666667];
    self.isTouchEnabled = YES;
    
    return self;
}

-(void)gameLoop:(ccTime)dt 
{
    [self updatePhysics: dt];
    [self draw];
}

-(void)updatePhysics:(ccTime)dt
{
    [Physics updateGravityOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics updateVelocityOfRigidBody:self.rigidBody overTimeDelta:dt];
    [Physics updatePositionOfRigidBody:self.rigidBody overTimeDelta:dt];
}

-(void)draw
{
    self.player.position = ccp(self.rigidBody.position.x, self.rigidBody.position.y);
    [self drawRigidBodies];
}

-(void)drawRigidBodies
{
    for(int i = 0; [self.rigidBody.points count]; i++)
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
        
        ccDrawLine(ccp(pointA.x, pointA.y), ccp(pointB.x, pointB.y));
    }
}

-(void)dealloc
{
	[super dealloc];
}

@end
