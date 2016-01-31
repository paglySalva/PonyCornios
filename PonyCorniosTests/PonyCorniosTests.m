//
//  PonyCorniosTests.m
//  PonyCorniosTests
//
//  Created by Pablo Salvá on 28/09/15.
//  Copyright (c) 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <MagicalRecord/MagicalRecord.h>
#import "PNCConstants.h"

//Models
#import "Team.h"
#import "Player.h"
#import "Match.h"
#import "Stat.h"

#pragma mark - 
#pragma mark - Private Interface

@interface PonyCorniosTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *mockContext;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PonyCorniosTests

#pragma mark -
#pragma mark - XCTest

- (void)setUp {
    [super setUp];
    
    [MagicalRecord cleanUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.mockContext = [NSManagedObjectContext MR_defaultContext];
}

- (void)tearDown {
    [super tearDown];
    
    [MagicalRecord cleanUp];
}

#pragma mark - 
#pragma mark - Creation

- (void)testCreateTeam {
    Team *team1 = [self  mockupTeam];
    
    XCTAssertEqual(team1.name, @"team 1");
}

- (void)testCreatePlayer {
    Player *player1 = [self mockupPlayer];
    
    XCTAssertEqual(player1.name, @"player 1");
    XCTAssertEqualObjects(player1.number, @(1));
}

- (void)testCreateMatch {
    
    Match *match1 = [self mockupMatch];
    
    XCTAssertEqual(match1.name,@"team 1", @"\n Test match name shoul be named team 1 !!");
    XCTAssertTrue([[NSDate date] compare:match1.date] == NSOrderedDescending, @"\n Current date should be NSOrderedDescending!!");
}

- (void)testCreateStat {
    Stat *stat1 = [self mockupStat];
    
    XCTAssertEqualObjects(stat1.name, @"stat 1", @"\n Test stat name should be named stat 1");
}

- (void)testCreateBaseStats {
    NSArray *baseStats = [Stat baseStatsForMatch:nil inContext:self.mockContext];
    
    XCTAssert(baseStats.count == 12, @"Base stats json has 5 instances!!");
}

- (void)testComplete {
    //Teams
    Team *homeTeam      = [Team teamWithData:@{@"teamName" : @"Home Team"} context:self.mockContext];
    Team *visitorTeam   = [Team teamWithData:@{@"teamName" : @"Visitor Team"} context:self.mockContext];
    
    //Match
    Match *match1    = [self mockupMatch];
    Match *match2    = [Match matchWithData: @{@"matchName" : @"team 1",
                                               @"matchDate" : [NSDate date]} context:self.mockContext];
    
    //Players
    NSArray *homePlayers = [Player basePlayersHome:YES InContext:self.mockContext];
    [homeTeam addPlayers:[NSSet setWithArray:homePlayers]];
    
    NSArray *visitorPlayers = [Player basePlayersHome:NO InContext:self.mockContext];
    [visitorTeam addPlayers:[NSSet setWithArray:visitorPlayers]];
    
    //Stats
    for (Player *player in homePlayers) {
        [player addStats:[NSSet setWithArray:[Stat baseStatsForMatch:match1 inContext:self.mockContext]]];
        [player addStats:[NSSet setWithArray:[Stat baseStatsForMatch:match2 inContext:self.mockContext]]];
    }
    
    for (Player *player in visitorPlayers) {
        [player addStats:[NSSet setWithArray:[Stat baseStatsForMatch:match1 inContext:self.mockContext]]];
    }
    
    match1.home    = homeTeam;
    match1.visitor = visitorTeam;
    
    Player *homePlayer = [homeTeam.players anyObject];
    [homePlayer increaseStatisticKey:PNC_2PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    [homePlayer increaseStatisticKey:PNC_2PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    [homePlayer increaseStatisticKey:PNC_3PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    
    //Other match
    [homePlayer increaseStatisticKey:PNC_2PT_CON inMatch:match2 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    
    Player *visitorPlayer = [visitorTeam.players anyObject];
    [visitorPlayer increaseStatisticKey:PNC_2PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    [visitorPlayer increaseStatisticKey:PNC_2PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    [visitorPlayer increaseStatisticKey:PNC_2PT_CON inMatch:match1 inQuarter:PNCQuaerterFirst inContext:self.mockContext];
    
    XCTAssert([homePlayer valueForStatisticKey:PNC_2PT_CON inMatch:match1 inContext:self.mockContext] == 4);
    XCTAssert([homePlayer valueForStatisticKey:PNC_2PT_CON inMatch:nil inContext:self.mockContext] == 6);
    XCTAssert([visitorPlayer valueForStatisticKey:PNC_2PT_CON inMatch:match1 inContext:self.mockContext] == 6);
    
    XCTAssert([match1 scoreFromTeam:MatchTeamHome context:self.mockContext] == 7);
    XCTAssert([match1 scoreFromTeam:MatchTeamVisitor context:self.mockContext] == 6);
}

#pragma mark -
#pragma mark - Additions

- (void)testAddPlayertoTeam {

   Team   *team1 = [self mockupTeam];
   Player *player1 = [self mockupPlayer];
    
   [team1 addPlayers:[NSSet setWithObject:player1]];
    
    XCTAssert(team1.players.count == 1, @"\n Total players should be 1 in this team!!");
}

#pragma mark - 
#pragma mark - Helpers

- (Match *)mockupMatch {
    return [Match matchWithData:[self matchDictionary] context:self.mockContext];
}

- (Team *)mockupTeam {
    return [Team teamWithData:[self teamDictionary] context:self.mockContext];
}

- (Player *)mockupPlayer {
    return [Player playerWithData:[self playerDictionary] context:self.mockContext];
}

- (Stat *)mockupStat {
    return [Stat statWithData:[self statDictionary] forMatch:nil context:self.mockContext];
}

- (NSDictionary *)matchDictionary {
    return @{@"matchName" : @"team 1",
             @"matchDate" : [NSDate date]};
}

- (NSDictionary *)teamDictionary {
    return @{@"teamName" : @"team 1"};
}

- (NSDictionary *)playerDictionary {
    return @{@"playerName" : @"player 1",
             @"playerNumber" : @(1)};
}

- (NSDictionary *)statDictionary {
    return @{
            @"statName"    : @"stat 1",
            @"statValue"   : @(0),
            @"statFormula" : @"",
            @"statAcronym" : @"ST1"
            };
}

@end
