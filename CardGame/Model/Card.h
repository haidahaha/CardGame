//
//  Card.h
//  CardGame
//
//  Created by Beo Bo on 1/31/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;
@end
