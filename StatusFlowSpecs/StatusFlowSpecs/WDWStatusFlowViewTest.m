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
@property (nonatomic, assign) WDWStatusFlowViewDirection direction;
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
        
        it(@"initializes the direction to horizontal", ^{
            expect(view.direction).to.equal(WDWStatusFlowViewDirectionHorizontal);
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
        
        it(@"initializes the direction to horizontal", ^{
            expect(view.direction).to.equal(WDWStatusFlowViewDirectionHorizontal);
        });
    });

    describe(@"#selectedIndex", ^{
        __block id statusFlowViewMock;
        
        beforeEach(^{
            statusFlowViewMock = OCMPartialMock(view);
            // NOTE: stubs are so we don't reset the layout setting these properties directly
            OCMStub([statusFlowViewMock direction]).andReturn(WDWStatusFlowViewDirectionVertical);
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
        
        context(@"updates the flow layout", ^{
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
            
            it(@"initializes the flow layout with the current direction", ^{
                expect(layout.direction).to.equal(WDWStatusFlowViewDirectionVertical);
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
            // NOTE: stubs are so we don't reset the layout setting these properties directly
            OCMStub([statusFlowViewMock selectedIndex]).andReturn(5);
            OCMStub([statusFlowViewMock direction]).andReturn(WDWStatusFlowViewDirectionVertical);
            view.gapBetweenCells = 55;
        });
        
        it(@"sets the gap property", ^{
            expect(view.gapBetweenCells).to.equal(55);
        });
        
        context(@"updates the flow layout", ^{
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
            
            it(@"initializes the flow layout with the current direction", ^{
                expect(layout.direction).to.equal(WDWStatusFlowViewDirectionVertical);
            });
            
            it(@"sets the gap inbetween cells", ^{
                expect(layout.gapBetweenCells).to.equal(55);
            });
        });
    });
    
    describe(@"#setDirection:", ^{
        __block id statusFlowViewMock;
        
        beforeEach(^{
            statusFlowViewMock = OCMPartialMock(view);
            // NOTE: stubs are so we don't reset the layout setting these properties directly
            OCMStub([statusFlowViewMock selectedIndex]).andReturn(5);
            OCMStub([statusFlowViewMock gapBetweenCells]).andReturn(44);
            view.direction = WDWStatusFlowViewDirectionVertical;
        });
        
        it(@"sets the direction property", ^{
            expect(view.direction).to.equal(WDWStatusFlowViewDirectionVertical);
        });
        
        context(@"updates the flow layout", ^{
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
            
            it(@"initializes the flow layout with the current direction", ^{
                expect(layout.direction).to.equal(WDWStatusFlowViewDirectionVertical);
            });
            
            it(@"sets the gap inbetween cells", ^{
                expect(layout.gapBetweenCells).to.equal(44);
            });
        });
    });
});

SpecEnd
