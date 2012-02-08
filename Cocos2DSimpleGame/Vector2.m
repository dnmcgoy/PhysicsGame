#import "Vector2.h"

@implementation Vector2

@synthesize x;
@synthesize y;

-(id)init
{
    if (self = [super init])
    {
        self.x = 0;
        self.y = 0;
    }
    
    return self;
}

-(id)initWithX:(double)newX
          andY:(double)newY
{
    if (self = [super init])
    {
        self.x = newX;
        self.y = newY;
    }
    
    return self;
}

-(Vector2*)vectorByAddingVector:(Vector2*)other
{
    Vector2* sum = [[Vector2 alloc] init];
    sum.x = self.x + other.x;
    sum.y = self.y + other.y;
    return sum;
}

-(Vector2*)vectorBySubtractingVector:(Vector2*)other
{
    Vector2* difference = [[Vector2 alloc] init];
    difference.x = self.x - other.x;
    difference.y = self.y - other.y;
    return difference;
}

-(Vector2*)vectorByMultiplication:(double)multiplier
{
    Vector2* product = [[Vector2 alloc] init];
    product.x = self.x * multiplier;
    product.y = self.y * multiplier;
    return product;
}

-(Vector2*)vectorByDivision:(double)divisor
{
    Vector2* quotient = [[Vector2 alloc] init];
    quotient.x = self.x / divisor;
    quotient.y = self.y / divisor;
    return quotient;
}

-(double) dotProductWithVector:(Vector2*)other
{
	return (self.x * other.x) + (self.y * other.y);
}

-(Vector3*) vectorByCrossProductWithVector:(Vector2 *)other
{
    return [[Vector3 alloc] initWithX:0 
                                 andY:0 
                                 andZ:(self.x * other.y) - (self.y * other.x)];
}

-(Vector2*) vectorByCrossProductWithZ
{
	Vector3* zAxis = [[Vector3 alloc] initWithX:0 
                                           andY:0 
                                           andZ:1];
    
	Vector3* thisVector = [[Vector3 alloc] initWithX:self.x 
                                                andY:self.y 
                                                andZ:0];
    
	Vector3* result = [thisVector vectorByCrossProductWithVector:zAxis];
    
	return [[Vector2 alloc] initWithX:result.x 
                                 andY:result.y];
}

-(Vector2*) vectorByCrossProductWithNegativeZ
{
	Vector3* zAxis = [[Vector3 alloc] initWithX:0 
                                           andY:0 
                                           andZ:-1];
    
	Vector3* thisVector = [[Vector3 alloc] initWithX:self.x 
                                                andY:self.y 
                                                andZ:0];
    
	Vector3* result = [thisVector vectorByCrossProductWithVector:zAxis];
    
	return [[Vector2 alloc] initWithX:result.x 
                                 andY:result.y];
}

-(BOOL)isInteriorToVector:(Vector2*)other
{
	return (self.x * other.y) - (self.y * other.x) < 0;
}

-(double)getLength
{
	return sqrt(pow(self.x, 2) + pow(self.y, 2));
}

-(double)distanceToVector:(Vector2*) other
{
	return sqrt(pow(self.x - other.x, 2) + pow(self.y - other.y, 2));
}

-(Vector2*)vectorByNormalization
{
	double length = self.getLength;
    double newX = self.x / length;
    double newY = self.y / length;
	return [[Vector2 alloc] initWithX:newX 
                                 andY:newY];
}

-(Vector2*) vectorByNormalToThisVector
{
	Vector3* zAxis = [[Vector3 alloc] initWithX:0 
                                           andY:0 
                                           andZ:1];
    
	Vector3* thisVector = [[Vector3 alloc] initWithX:self.x 
                                                andY:self.y 
                                                andZ:0];
    
	Vector3* normal = [zAxis vectorByCrossProductWithVector:thisVector];
	normal = [normal vectorByNormalization];
    
    return [[Vector2 alloc] initWithX:normal.x 
                                 andY:normal.y];
}

// Counterclockwise
-(Vector2*) vectorByRotationInDegrees:(double)degrees
{
	double theta = degrees * 3.14159 / 180.0;
    double newX = (self.x * cos(theta)) - (self.y * sin(theta));
    double newY = (self.y * cos(theta)) + (self.x * sin(theta));
	return [[Vector2 alloc] initWithX:newX 
                                 andY:newY];
}

-(double) angleInDegreesWithVector:(Vector2*) other
{
    // returns an angle between -180 and 180, which is more useful than 0 to 360
    
	double angleInDegrees = 180 * (atan2(other.y, other.x) - atan2(self.y, self.x)) / 3.14159; 
    
	if(angleInDegrees < -180)
    {
		angleInDegrees += 360;
    }
	else if(angleInDegrees > 180)
    {
		angleInDegrees -= 360;
    }
    
	return angleInDegrees;
}

-(Vector2*) vectorByProjectionOntoThisVector:(Vector2*) other
{
    // http://www.math.oregonstate.edu/home/programs/undergrad/CalculusQuestStudyGuides/vcalc/dotprod/dotprod.html
    
    double length = [self getLength];
    double dotProduct = [self dotProductWithVector:other];
    Vector2* normalizedVector = [self vectorByNormalization];
	return [normalizedVector vectorByMultiplication:(dotProduct / length)];
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"Vector2: %f,%f", self.x, self.y];
}

-(Vector3*)toVector3
{
    return [[Vector3 alloc] initWithX:self.x andY:self.y andZ:0];
}

@end
