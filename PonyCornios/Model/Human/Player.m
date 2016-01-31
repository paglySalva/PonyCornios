#import "Player.h"

//Models
#import "Stat.h"
#import "Match.h"

@interface Player ()

// Private interface goes here.

@end

@implementation Player

#pragma mark -
#pragma mark -Initializers

+ (Player *)playerWithData:(NSDictionary *)playerData context:(NSManagedObjectContext *)context {
    return [[Player alloc]initPlayerWithData:playerData context:context];
}

- (instancetype)initPlayerWithData:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    
    Player *newPlayer = [Player MR_createEntityInContext:context];
    newPlayer.name        = data[@"playerName"];
    newPlayer.numberValue = [data[@"playerNumber"] integerValue];
    
    if (data[@"playerImageName"]) {
        UIImage *image = [UIImage imageNamed:data[@"playerImageName"]];
        newPlayer.photo = UIImageJPEGRepresentation(image, 0.4);
    }
    
    return newPlayer;
    
}

#pragma mark -
#pragma mark - Public Methods

- (void)increaseStatisticKey:(NSString *)statKey inMatch:(Match *)match inQuarter:(PNCQuarter)quarter inContext:(NSManagedObjectContext *)context {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@ AND %K == %@",
                              StatRelationships.player,
                              self,
                              StatAttributes.acronym,
                              statKey,
                              StatRelationships.match,
                              match];
    
    Stat *stat = [Stat MR_findFirstWithPredicate:predicate inContext:context];
    [self increaseStatistic:stat inQuarter:quarter inContext:context];
}

- (void)decreaseStatisticKey:(NSString *)statKey inMatch:(Match *)match inQuarter:(PNCQuarter)quarter inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@ AND %K == %@",
                              StatRelationships.player,
                              self,
                              StatAttributes.acronym,
                              statKey,
                              StatRelationships.match, match];
    
    Stat *stat = [Stat MR_findFirstWithPredicate:predicate inContext:context];
    [self decreaseStatistic:stat inContext:context];
}

- (NSUInteger)valueForStatisticKey:(NSString *)statKey inMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    
    if (!match) {
        return [self allValueForStatisticKey:statKey inMatch:match inContext:context];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@  AND %K == %@",
                 StatRelationships.player,
                 self,
                 StatAttributes.acronym,
                 statKey,
                 StatRelationships.match, match];
    
    Stat *stat = [Stat MR_findFirstWithPredicate:predicate inContext:context];
    
    return (stat) ? [Player evaluateEquation:stat.formula times:stat.valueValue] : 0;
}

- (NSUInteger)allValueForStatisticKey:(NSString *)statKey inMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@ ",
                              StatRelationships.player,
                              self, StatAttributes.acronym,
                              statKey];
    
    NSArray *stats = [Stat MR_findAllWithPredicate:predicate inContext:context];
    
    NSInteger total = 0;
    for (Stat *stat in stats) {
        NSInteger result = [Player evaluateEquation:stat.formula times:stat.valueValue];
        total += result;
    }
    
    return total;
}

- (NSUInteger)allPointsConvertedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    NSUInteger One   = [self valueForStatisticKey:PNC_1PT_CON inMatch:match inContext:context];
    NSUInteger Two   = [self valueForStatisticKey:PNC_2PT_CON inMatch:match inContext:context];
    NSUInteger Three = [self valueForStatisticKey:PNC_3PT_CON inMatch:match inContext:context];
    
    return One + Two + Three;
}

- (NSUInteger)allPointsFailedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    NSUInteger One   = [self valueForStatisticKey:PNC_1PT_FALL inMatch:match inContext:context];
    NSUInteger Two   = [self valueForStatisticKey:PNC_2PT_FALL inMatch:match inContext:context];
    NSUInteger Three = [self valueForStatisticKey:PNC_3PT_FALL inMatch:match inContext:context];
    
    return One + Two + Three;
}

- (NSUInteger)allShotsFailedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    NSUInteger One   = [self valueForStatisticKey:PNC_1PT_FALL inMatch:match inContext:context];
    NSUInteger Two   = [self valueForStatisticKey:PNC_2PT_FALL inMatch:match inContext:context] /2;
    NSUInteger Three = [self valueForStatisticKey:PNC_3PT_FALL inMatch:match inContext:context] /3;
    
    return One + Two + Three;
}

#pragma mark -
#pragma mark -Querys

- (UIImage *)photoImage {
    return (self.photo) ? [UIImage imageWithData:self.photo] : [self placeholderPlayer];
}

- (Stat *)statisticWithKey:(NSString *)statKey inMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@  AND %K == %@",
                              StatRelationships.player,
                              self,
                              StatAttributes.acronym,
                              statKey,
                              StatRelationships.match, match];
    
    return [Stat MR_findFirstWithPredicate:predicate inContext:context];
}

- (UIImage *)placeholderPlayer {
    return (self.team.logoImage) ?: [UIImage imageNamed:@"playerPlaceholder"];
}

- (NSUInteger)matches {
//    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"%K == nil", StatRelationships.events];
//    NSArray *stats = [Stat MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];

    
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"%K == nil AND %K == %@",StatRelationships.events, StatRelationships.player, self];
//    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"self.stats.events == nil AND self.stats.player == %@",StatRelationships.player, self];
    NSArray *stats = [Stat MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    //NSArray *stats = [Match MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    
    
    return stats.count;
}

#pragma mark -
#pragma mark - Fetch Requests

+ (NSFetchRequest *)FRPlayersInTeam:(Team *)team {
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"%K == %@", PlayerRelationships.team, team];
    return [Player MR_requestAllSortedBy:PlayerAttributes.number ascending:YES withPredicate:predicate];
}

#pragma mark
#pragma mark - Private Methods

- (void)increaseStatistic:(Stat *)stat inQuarter:(PNCQuarter)quarter inContext:(NSManagedObjectContext *)context {
    
    stat.valueValue ++;
    stat.savedData = [NSDate date];
    
    //When stat increases a new event is created.
    Event *event = [Event eventWithDate:[NSDate date] context:context];
    event.quarterValue = quarter;
    event.stat = [stat MR_inContext:context];
}

- (void)decreaseStatistic:(Stat *)stat inContext:(NSManagedObjectContext *)context {
    
    stat.valueValue --;
    stat.savedData = [NSDate date];
    
    //When stat decreases its event is deleted.
    //TODO: Delete event
}

+ (NSDictionary *)basePlayersJsonFile:(BOOL)isHome {
    
    NSString *playersFile = (isHome) ? @"homePlayers" : @"visitorPlayers";
    
    NSString *dataFile = [[NSBundle mainBundle]pathForResource:playersFile ofType:@"json"];
    NSData *data       = [NSData dataWithContentsOfFile:dataFile];
    
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:0
                                             error:&error];
}

#pragma mark -
#pragma mark - Helpers

+ (NSArray *)basePlayersHome:(BOOL)isHome InContext:(NSManagedObjectContext *)context {
    
    NSDictionary * dict     = [Player basePlayersJsonFile:isHome];
    NSMutableArray *players = [NSMutableArray new];
    
    for (NSDictionary *stat in dict[@"players"]) {
        [players addObject:[[Player alloc] initPlayerWithData:stat context:context]];
    }
    
    return [players copy];
}

+ (NSUInteger)evaluateEquation:(NSString *)equation times:(NSInteger)times {
    
    NSString *formula = equation;
    NSInteger x = times;
    
    NSExpression *expr = [NSExpression expressionWithFormat:formula];
    NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:x], @"x", nil];
    
    return [[expr expressionValueWithObject:object context:nil] integerValue];
}

- (NSUInteger)valorationInMatch:(Match *)match context:(NSManagedObjectContext *)context {
    
    //Succes Points
    NSUInteger succsPoints    = [self allPointsConvertedInMatch:match inContext:context];
    
    //Rebounds
    NSUInteger reboundsOF     = [self valueForStatisticKey:PNC_RBA inMatch:match inContext:context];
    NSUInteger reboundsDEF    = [self valueForStatisticKey:PNC_RBD inMatch:match inContext:context];
    NSUInteger rebounds       = reboundsOF + reboundsDEF;
    
    //Assistances
    NSUInteger assistances    = [self valueForStatisticKey:PNC_ASIS inMatch:match inContext:context];
    
    //Steals
    NSUInteger steals         = [self valueForStatisticKey:PNC_ROB inMatch:match inContext:context];
    
    //Blocks
    NSUInteger blocks         = [self valueForStatisticKey:PNC_TAP inMatch:match inContext:context];
    
    //Failed Poitns
    NSUInteger failPoints     = [self allShotsFailedInMatch:match inContext:context];
    
    //Losses
    NSUInteger losses         = [self valueForStatisticKey:PNC_PERD inMatch:match inContext:context];
    
    //Faults
    //NSUInteger faults         = [self valueForStatisticKey:PNC_FALT inMatch:match inContext:context];
    
    NSInteger valoration      = succsPoints + rebounds + assistances + steals + blocks - failPoints - losses;
    return valoration;
}

@end
