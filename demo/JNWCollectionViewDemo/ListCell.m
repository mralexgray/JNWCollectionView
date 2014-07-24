//
//  ListCell.m
//  JNWCollectionViewDemo
//
//  Created by Jonathan Willing on 3/23/13.
//  Copyright (c) 2013 AppJon. All rights reserved.
//

#import "ListCell.h"
#import "NSImage+DemoAdditions.h"
#import "JNWLabel.h"
#import "DemoImageCache.h"

@interface ListCell()
@property (nonatomic, strong) JNWLabel *label;
@end

@implementation ListCell

- (instancetype)initWithFrame:(NSRect)frameRect {

  return self = [super initWithFrame:frameRect]
              ? [self.contentView addSubview:_label = [JNWLabel.alloc initWithFrame:CGRectZero]], self : nil;
}
- (void)layout { [super layout];
	
	CGRect labelRect = CGRectMake(15, 10, 100, 20);
	self.label.frame = !CGRectEqualToRect(labelRect, self.label.frame) ? labelRect :self.label.frame;
}

- (void)setCellLabelText:(NSString *)cellLabelText { _cellLabelText = self.label.text = cellLabelText; }

- (void)setSelected:(BOOL)selected { [super setSelected:selected]; [self updateBackgroundImage]; }

- (void)updateBackgroundImage {

	NSString *identifier = [NSString stringWithFormat:@"%@%x", NSStringFromClass(self.class), self.selected];
	CGSize size = CGSizeMake(1, CGRectGetHeight(self.bounds));
	self.backgroundImage  = [DemoImageCache.sharedCache cachedImageWithIdentifier:identifier size:size withCreationBlock:^NSImage * (CGSize size) {
    return self.selected  ? [NSImage highlightedGradientImageWithHeight:size.height]
                          : [NSImage standardGradientImageWithHeight:size.height];
  }];
}

@end
