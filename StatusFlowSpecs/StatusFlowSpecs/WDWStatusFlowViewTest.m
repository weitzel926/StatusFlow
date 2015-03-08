#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "WDWStatusFlowView.h"
#import "WDWStatusFlowLayout.H"

@interface WDWStatusFlowView (Test)

@end

@interface WDWStatusFlowLayout (Test)
@property (nonatomic, strong) NSIndexPath *selectedItemPath;
@end

SpecBegin(WDWStatusFlowView)

describe(@"WDWStatusFlowView", ^{
    __block WDWStatusFlowView *view;
    
    beforeEach(^{
        view = [[WDWStatusFlowView alloc] initWithCoder:nil];
    });

    describe(@"#initWithCoder:", ^{
        it(@"initializes the selected index", ^{
            expect(view.selectedIndex).to.equal(0);
        });
        
        it(@"initializes the gap between cells", ^{
            expect(view.gapBetweenCells).to.equal(5);
        });
        
        it(@"forces scrolling to off", ^{
            expect(view.scrollEnabled).to.beFalsy();
        });
        
        it(@"turns scroll indicators off", ^{
            expect(view.showsHorizontalScrollIndicator).to.beFalsy();
            expect(view.showsVerticalScrollIndicator).to.beFalsy();
        });
    });
    
    describe(@"#initWithFrame", ^{
        __block WDWStatusFlowView *frameView;
        
        beforeEach(^{
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGRect rect = CGRectMake(0,0,100,100);
            frameView = [[WDWStatusFlowView alloc] initWithFrame:rect collectionViewLayout:layout];
        });
        
        it(@"initializes the selected index", ^{
            expect(view.selectedIndex).to.equal(0);
        });
        
        it(@"initializes the gap between cells", ^{
            expect(view.gapBetweenCells).to.equal(5);
        });
        
        it(@"forces scrolling to off", ^{
            expect(view.scrollEnabled).to.beFalsy();
        });
        
        it(@"turns scroll indicators off", ^{
            expect(view.showsHorizontalScrollIndicator).to.beFalsy();
            expect(view.showsVerticalScrollIndicator).to.beFalsy();
        });

    });

    describe(@"#selectedIndex", ^{
        __block id statusFlowViewMock;
        
        beforeEach(^{
            statusFlowViewMock = OCMPartialMock(view);
            OCMStub([statusFlowViewMock gapBetweenCells]).andReturn(44);
            view.selectedIndex = 4;
        });
        
        it(@"sets the selected item", ^{
            NSIndexPath *index = [NSIndexPath indexPathForRow:4 inSection:0];
            OCMVerify([statusFlowViewMock selectItemAtIndexPath:index
                                                       animated:NO
                                                 scrollPosition:UICollectionViewScrollPositionNone]);
        });
        
        it(@"sets the value of the selectedIndex property", ^{
            expect(view.selectedIndex).to.equal(4);
        });
        
        context(@"update the flow layout", ^{
            __block WDWStatusFlowLayout *layout;
            
            beforeEach(^{
                layout = (WDWStatusFlowLayout *)view.collectionViewLayout;
            });
            
            it(@"creates and sets the collection view layout with animation", ^{
                OCMVerify([statusFlowViewMock setCollectionViewLayout:[OCMArg any]
                                                             animated:YES]);
            });
            
            it(@"initializes the flow layout with the selected index path", ^{
                expect(layout.selectedItemPath).to.equal([NSIndexPath indexPathForRow:4 inSection:0]);
            });
            
            it(@"sets the gap inbetween cells", ^{
                expect(layout.gapBetweenCells).to.equal(44);
            });
        });
    });
    
    describe(@"#setGapBetweenCells:", ^{
        __block id statusFlowViewMock;
        
        beforeEach(^{
            statusFlowViewMock = OCMPartialMock(view);
            OCMStub([statusFlowViewMock selectedIndex]).andReturn(5);
            view.gapBetweenCells = 55;
        });
        
        it(@"sets the gap property", ^{
            expect(view.gapBetweenCells).to.equal(55);
        });
        
        context(@"update the flow layout", ^{
            __block WDWStatusFlowLayout *layout;
            
            beforeEach(^{
                layout = (WDWStatusFlowLayout *)view.collectionViewLayout;
            });
            
            it(@"creates and sets the collection view layout with animation", ^{
                OCMVerify([statusFlowViewMock setCollectionViewLayout:[OCMArg any]
                                                             animated:YES]);
            });
            
            it(@"initializes the flow layout with the selected index path", ^{
                expect(layout.selectedItemPath).to.equal([NSIndexPath indexPathForRow:5 inSection:0]);
            });
            
            it(@"sets the gap inbetween cells", ^{
                expect(layout.gapBetweenCells).to.equal(55);
            });
        });
    });
    
});

SpecEnd
