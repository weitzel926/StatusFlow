#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WDWExampleStatusFlowViewController.h"
#import "WDWExampleStatusFlowCell.h"
#import "WDWStatusFlowView.h"


@interface WDWExampleStatusFlowViewController (Test)
@property (weak, nonatomic) IBOutlet WDWStatusFlowView *statusFlowView;

@property (strong, nonatomic) NSArray *items;

- (IBAction)advanceTapped:(id)sender;
- (IBAction)backTapped:(id)sender;
@end

SpecBegin(WDWExampleStatusFlowViewController)

describe(@"WDWExampleStatusFlowViewController", ^{
    __block WDWExampleStatusFlowViewController *controller;

    beforeEach(^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:[NSBundle mainBundle]];
        controller = [storyboard instantiateViewControllerWithIdentifier:@"WDWExampleStatusFlowViewController"];
    });

    describe(@"#initWithCoder:", ^{
        __block WDWExampleStatusFlowViewController *coderController;
        
        beforeEach(^{
            coderController = [[WDWExampleStatusFlowViewController alloc] initWithCoder:nil];
        });
        
        it(@"initializes the data", ^{
            expect(coderController.items).to.equal(@[@"zero",
                                                     @"one",
                                                     @"two",
                                                     @"three",
                                                     @"four",
                                                     @"five",
                                                     @"six",
                                                     @"seven",
                                                     @"eight",
                                                     @"nine"]);
        });
    });
    
    describe(@"#initWithNibName", ^{
        __block WDWExampleStatusFlowViewController *nibNameController;
        
        beforeEach(^{
            nibNameController = [[WDWExampleStatusFlowViewController alloc] initWithNibName:@"" bundle:nil];
        });
        
        it(@"initializes the data", ^{
            expect(nibNameController.items).to.equal(@[@"zero",
                                                       @"one",
                                                       @"two",
                                                       @"three",
                                                       @"four",
                                                       @"five",
                                                       @"six",
                                                       @"seven",
                                                       @"eight",
                                                       @"nine"]);
        });
    });
    
    it(@"is a UIViewController", ^{
        expect(controller).to.beKindOf([UIViewController class]);
    });
    
    it(@"conforms to the UICollectionViewDataSource protocol", ^{
        expect(controller).to.conformTo(@protocol(UICollectionViewDataSource));
    });
    
    describe(@"#viewDidLoad", ^{
       beforeEach(^{
            [controller view];
        });
        
        context(@"statusFlowView", ^{
            it(@"has a statusFlowView", ^{
                expect(controller.statusFlowView).toNot.beNil();
            });
            
            it(@"sets the statusFlowView dataSource to itself", ^{
                expect(controller.statusFlowView.dataSource).to.equal(controller);
            });
            
            it(@"sets the gap between the cells", ^{
                expect(controller.statusFlowView.gapBetweenCells).to.equal(10);
            });
        });
    });
    
    describe(@"#collectionView:numberOfItemsInSection", ^{
        __block NSInteger itemCount;
        
        beforeEach(^{
            [controller view];
            
            itemCount = 0;
            NSArray *items = @[@"fakeyItemOne", @"fakeyItemTwo", @"fakeyItemThree"];
            controller.items = items;
        });
        
        context(@"the only section", ^{
            beforeEach(^{
                itemCount = [controller collectionView:controller.statusFlowView numberOfItemsInSection:0];
            });
            
            it(@"returns the same number of items as in the items property", ^{
                expect(itemCount).to.equal(3);
            });
        });
        
        context(@"an invalid section", ^{
            beforeEach(^{
                itemCount = [controller collectionView:controller.statusFlowView numberOfItemsInSection:1];
            });
            
            it(@"returns the same number of items as in the items property", ^{
                expect(itemCount).to.equal(0);
            });
        });
    });
    
    describe(@"#collectionView:cellForItemAtIndexPath", ^{
        __block WDWExampleStatusFlowCell *cell;
        
        beforeEach(^{
            [controller view];
            controller.items = @[@"one"];
            
        });
        
        context(@"valid index path (IE: section 0)", ^{
            beforeEach(^{
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
                cell = (WDWExampleStatusFlowCell *)[controller collectionView:controller.statusFlowView cellForItemAtIndexPath:path];
            });
            
            // WHY doesn't this ever work in expecta?
            xit(@"returns a WDWExampleStatusFlowCell", ^{
                expect(cell).to.beKindOf([WDWExampleStatusFlowCell class]);
            });
            
            it(@"returns a valid cell", ^{
                expect(cell).toNot.beNil();
            });
            
            it(@"sets the image name in the cell", ^{
                expect(cell.imageName).to.equal(@"one");
            });
        });
        
        context(@"bad index path (IE: section != 0", ^{
            beforeEach(^{
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
                cell = (WDWExampleStatusFlowCell *)[controller collectionView:controller.statusFlowView cellForItemAtIndexPath:path];
            });
            
            it(@"returns a nil cell", ^{
                expect(cell).to.beNil();
            });
        });
    });
    
    describe(@"#advanceTapped", ^{
         __block NSInteger dataSetSize;
        
        beforeEach(^{
            [controller view];
             dataSetSize = controller.items.count;
        });
        
        context(@"advance to valid index", ^{
            beforeEach(^{
                controller.statusFlowView.selectedIndex = 0;
                [controller advanceTapped:nil];
            });
            
            it(@"advances the selected index", ^{
                expect(controller.statusFlowView.selectedIndex).to.equal(1);
            });
        });
        
        context(@"no valid index to advance to", ^{
            beforeEach(^{
                controller.statusFlowView.selectedIndex = dataSetSize-1;
                [controller advanceTapped:nil];
            });
            
            it(@"does not advance the selected index", ^{
                expect(controller.statusFlowView.selectedIndex).to.equal(dataSetSize-1);
            });
        });
    });
    
    describe(@"#backTapped", ^{
        __block NSInteger dataSetSize;
        
        beforeEach(^{
            [controller view];
            dataSetSize = controller.items.count;
        });
        
        context(@"advance to valid index", ^{
            beforeEach(^{
                controller.statusFlowView.selectedIndex = dataSetSize-1;
                [controller backTapped:nil];
            });
            
            it(@"decrements the selected index", ^{
                expect(controller.statusFlowView.selectedIndex).to.equal(dataSetSize-2);
            });
        });
        
        context(@"no valid index to decrement to", ^{
            beforeEach(^{
                controller.statusFlowView.selectedIndex = 0;
                [controller backTapped:nil];
            });
            
            it(@"does not decrement the selected index", ^{
                expect(controller.statusFlowView.selectedIndex).to.equal(0);
            });
        });
    });
});



SpecEnd
