

#import "ListDemoViewController.h"
#import "ListHeader.h"
#import "ListCell.h"

@interface ListDemoViewController ()
@property (nonatomic) JNWCollectionView *collectionView;
@end

static NSString * const cellIdentifier    = @"CELL",
                * const headerIdentifier  = @"HEADER";

@implementation ListDemoViewController

- (id)init { return [super initWithNibName:nil bundle:nil]; }

- (void)loadView {

	self.view = [NSView.alloc initWithFrame:CGRectZero];
	self.view.wantsLayer = YES;
	
	[self.view addSubview:self.collectionView = [JNWCollectionView.alloc initWithFrame:self.view.bounds]];
	self.collectionView.autoresizingMask      = NSViewWidthSizable | NSViewHeightSizable;
	self.collectionView.dataSource            = self;
	JNWCollectionViewListLayout *layout       = JNWCollectionViewListLayout.new;
//	layout.rowHeight                          = 44.f;
	layout.delegate                           = self;
  layout.stickyHeaders                      = YES;
	self.collectionView.collectionViewLayout  = layout;
	
	[self.collectionView registerClass:ListCell.class   forCellWithReuseIdentifier:cellIdentifier];
	[self.collectionView registerClass:ListHeader.class forSupplementaryViewOfKind:JNWCollectionViewListLayoutHeaderKind withReuseIdentifier:headerIdentifier];
	
	self.collectionView.animatesSelection     = YES;
	[self.collectionView reloadData];
}

- (JNWCollectionViewCell*) collectionView:(JNWCollectionView*)cV cellForItemAtIndexPath:(NSIndexPath*)iP {
	ListCell *cell = (ListCell *)[cV dequeueReusableCellWithIdentifier:cellIdentifier];
	cell.cellLabelText = [NSString stringWithFormat:@"%ld - sect:%ld row:%lu", iP.jnw_item, iP.jnw_section,iP.length];
	return cell;
}

- (JNWCollectionViewReusableView*) collectionView:(JNWCollectionView*)cV viewForSupplementaryViewOfKind:(NSString*)k inSection:(NSInteger)sct {
	ListHeader *header     = (ListHeader*)[cV dequeueReusableSupplementaryViewOfKind:k withReuseIdentifer:headerIdentifier];
	header.headerLabelText = [NSString stringWithFormat:@"Header %ld", sct];
	return header;
}

// Can be used in place of setting the collective height of the layout, as seen above in `-loadView`, if
// a variable-row height list view is wanted.

- (CGFloat)collectionView:(JNWCollectionView *)collectionView heightForRowAtIndexPath:(NSIndexPath*)indexPath {

    return (arc4random() % 109) + 44.f;
}

- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 300;
}

- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
	return 5;
}

- (CGFloat)collectionView:(JNWCollectionView *)collectionView heightForHeaderInSection:(NSInteger)index {
	return 24.f;
}

@end
