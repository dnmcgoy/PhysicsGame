#import "cocos2d.h"
#import "RigidBody.h"
#import "Physics.h"

@interface HelloWorldLayer : CCLayerColor
{
}

+(CCScene *) scene;
-(void)updatePhysics: (ccTime)dt;
-(void)drawRigidBodies;
-(void)drawMap;

@property (nonatomic, retain) CCSprite* player;
@property (nonatomic, retain) RigidBody* rigidBody;
@property (nonatomic, retain) Map* map;

@end
