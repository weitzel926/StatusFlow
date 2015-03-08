#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WDWExampleStatusFlowCell.h"
#import "WDWExampleStatusFlowViewController.h"
#import "WDWStatusFlowView.h"

@interface WDWExampleStatusFlowCell (Test)
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@interface WDWExampleStatusFlowViewController (Test)
@property (weak, nonatomic) IBOutlet WDWStatusFlowView *statusFlowView;
@end

SpecBegin(WDWExampleStatusFlowCell)

describe(@"WDWExampleStatusFlowCell", ^{
    __block WDWExampleStatusFlowCell *cell;

    beforeEach(^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:[NSBundle mainBundle]];
        WDWExampleStatusFlowViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"WDWExampleStatusFlowViewController"];
        
        [controller view];
        
        cell = (WDWExampleStatusFlowCell *)[controller collectionView:controller.statusFlowView
                             cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
    });
    
    context(@"#setImageName", ^{
        beforeEach(^{
            [cell setImageName:@"one"];
        });
        
        it(@"sets the imageName property", ^{
            expect(cell.imageName).to.equal(@"one");
        });
        
        it(@"sets the image", ^{
            expect(cell.imageView.image).toNot.beNil();
            expect(cell.imageView.image).to.equal([UIImage imageNamed:@"one"]);
        });
    });
});

SpecEnd
