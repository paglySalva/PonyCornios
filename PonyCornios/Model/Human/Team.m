#import "Team.h"

@interface Team ()

// Private interface goes here.

@end

@implementation Team

+ (Team *)teamWithData:(NSDictionary *)teamData context:(NSManagedObjectContext *)context {
    return [[Team alloc]initTeamWithData:teamData context:context];
}

- (instancetype)initTeamWithData:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    Team *newTeam = [Team MR_createEntityInContext:context];
    newTeam.name = data[@"teamName"];
    
    return newTeam;
}

- (UIImage *)logoImage {
    return (self.logo) ? [UIImage imageWithData:self.logo] : [self placeholderTeam];
}

- (UIImage *)placeholderTeam {
    return [UIImage imageNamed:@"teamPlaceholder"];
}

#pragma mark -
#pragma mark - Querys 

+ (NSArray *)teamsIncontext:(NSManagedObjectContext *)context {
    return [Team MR_findAllInContext:context];
}

- (NSArray *)playersArray {
    return [self.players sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
}

#pragma mark -
#pragma mark - Requests

+ (NSFetchRequest *)FRTeams {
    return [Team MR_requestAllSortedBy:TeamAttributes.name ascending:YES];
}

@end
