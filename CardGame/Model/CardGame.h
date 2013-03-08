//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Beo Bo on 2/1/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (NSString *)flipCardAtIndex:(NSUInteger)index;

- (NSString *)flipCardHardModeAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@end
