#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <Swizzlean/Swizzlean.h>
#import "WDWStatusFlowLayout.h"

@interface WDWStatusFlowLayout (Test)
@property (nonatomic, strong) NSIndexPath *selectedItemPath;

-(void)modifyAttributes:(UICollectionViewLayoutAttributes *)attributes;
@end

SpecBegin(WDWStatusFlowLayout)

describe(@"WDWStatusFlowLayout", ^{
    __block WDWStatusFlowLayout *layout;

    beforeEach(^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        layout = [[WDWStatusFlowLayout alloc] initWithSelectedItemPath:indexPath];
    });
    
    it(@"sets the index path property", ^{
        expect(layout.selectedItemPath).to.equal([NSIndexPath indexPathForRow:3 inSection:0]);
    });
    
    it(@"defaults the gapBetweenCells property to 5", ^{
        expect(layout.gapBetweenCells).to.equal(5);
    });

    describe(@"#layoutAttributesForItemAtIndexPath:", ^{
        __block id layoutMock;
        __block id layoutAttributesMock;
        __block UICollectionViewLayoutAttributes *returnedAttributes;
        
        __block Swizzlean *flowLayoutSwizz;
        
        beforeEach(^{
            layoutAttributesMock = OCMClassMock([UICollectionViewLayoutAttributes class]);
            layoutMock = OCMPartialMock(layout);
            
            flowLayoutSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[UICollectionViewFlowLayout class]];
            [flowLayoutSwizz swizzleInstanceMethod:@selector(layoutAttributesForItemAtIndexPath:) withReplacementImplementation:
             ^(id _self){
                 return layoutAttributesMock;
             }];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            returnedAttributes = [layout layoutAttributesForItemAtIndexPath:indexPath];
        });
        
        afterEach(^{
            [flowLayoutSwizz resetSwizzledInstanceMethod];
        });
        
        it(@"returns the value from modify attributes", ^{
            OCMVerify([layoutMock modifyAttributes:layoutAttributesMock]);
        });
    });
    
    describe(@"#layoutAttributesForElementsInRect:", ^{
        __block id layoutMock;
        __block id layoutAttributesCell1Mock;
        __block id layoutAttributesCell2Mock;
        
        __block NSArray *returnedAttributes;
        
        __block Swizzlean *flowLayoutSwizz;

        beforeEach(^{
            layoutMock = OCMPartialMock(layout);
            
            layoutAttributesCell1Mock = OCMClassMock([UICollectionViewLayoutAttributes class]);
            layoutAttributesCell2Mock = OCMClassMock([UICollectionViewLayoutAttributes class]);

            CGRect elementsRect = CGRectMake(0,0,100,100);
            NSArray *attributesForRectArray = @[layoutAttributesCell1Mock,layoutAttributesCell2Mock];

            flowLayoutSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[UICollectionViewFlowLayout class]];
            [flowLayoutSwizz swizzleInstanceMethod:@selector(layoutAttributesForElementsInRect:) withReplacementImplementation:^(id _self){
                return attributesForRectArray;
            }];
            
            returnedAttributes = [layout layoutAttributesForElementsInRect:elementsRect];
        });

        afterEach(^{
            [flowLayoutSwizz resetSwizzledInstanceMethod];
        });
        
        it(@"modifies a set of layout attributes for each cell", ^{
            OCMVerify([layoutMock modifyAttributes:layoutAttributesCell1Mock]);
            OCMVerify([layoutMock modifyAttributes:layoutAttributesCell2Mock]);
        });
        
        it(@"returns a valid array of attributes", ^{
            expect(returnedAttributes.count).to.equal(2);
            expect(returnedAttributes).to.equal(@[layoutAttributesCell1Mock, layoutAttributesCell2Mock]);
        });
    });
    
    describe(@"#modifyAttributes", ^{
        __block UICollectionViewLayoutAttributes *attributes;
        __block NSIndexPath *selectedItemPath;
        
        __block Swizzlean *layoutSwizz;
        __block id collectionViewMock;
        
        beforeEach(^{
            collectionViewMock = OCMClassMock([UICollectionView class]);
            OCMStub([collectionViewMock frame]).andReturn(CGRectMake(0,0,1000,100));
            
            layoutSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[UICollectionViewFlowLayout class]];
            [layoutSwizz swizzleInstanceMethod:@selector(collectionView) withReplacementImplementation:^(id _self){
                return collectionViewMock;
            }];
            
            selectedItemPath = [NSIndexPath indexPathForItem:5 inSection:0];
            layout.selectedItemPath = selectedItemPath;
            layout.gapBetweenCells = 10;
            
            attributes = [[UICollectionViewLayoutAttributes alloc] init];
            attributes.center = CGPointMake(0,0);
            attributes.size = CGSizeMake(100,100);
        });
        
        afterEach(^{
            [layoutSwizz resetSwizzledInstanceMethod];
        });
        
        context(@"invalid index path (this should only ever have one section)", ^{
            beforeEach(^{
                attributes.indexPath = [NSIndexPath indexPathForRow:0 inSection:39];
                [layout modifyAttributes:attributes];
            });
            
            it(@"does not modify attributes", ^{
                expect(attributes.center).to.equal(CGPointMake(0,0));
                expect(attributes.size).to.equal(CGSizeMake(100,100));
            });
        });
        
        context(@"attributes are for cell in selected index path", ^{
            beforeEach(^{
                attributes.indexPath = layout.selectedItemPath;
                [layout modifyAttributes:attributes];
            });
            
            it(@"sets the cell as the center cell", ^{
                expect(attributes.center).to.equal(CGPointMake(500,50));
            });
            
            it(@"sets the correct transform", ^{
                
                expect(CGAffineTransformEqualToTransform(attributes.transform, CGAffineTransformMakeScale(2.0, 2.0))).to.beTruthy();
            });
            
            it(@"sets the hidden attribute to NO", ^{
                expect(attributes.hidden).to.equal(NO);
            });
        });
        
        context(@"attributes are for cell left of the selected index path", ^{
            context(@"visible cell", ^{
                beforeEach(^{
                    attributes.indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
                    [layout modifyAttributes:attributes];
                });
                
                it(@"sets the cell center (one position left of center)", ^{
                    expect(attributes.center).to.equal(CGPointMake(340,50));
                });
                
                it(@"sets the hidden attribute to NO", ^{
                    expect(attributes.hidden).to.equal(NO);
                });
            });
            
            context(@"hidden cell", ^{
                beforeEach(^{
                    attributes.indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                    [layout modifyAttributes:attributes];
                });
                
                it(@"sets the cell center (two positions left of center)", ^{
                    expect(attributes.center).to.equal(CGPointMake(230, 50));
                });
                
                it(@"sets the cell to be invisible", ^{
                    expect(attributes.alpha).to.equal(0);
                    expect(attributes.hidden).to.equal(YES);
                });
            });
        });
        
        context(@"attributes are for cell right of the selected index path", ^{
            context(@"visible cell", ^{
                beforeEach(^{
                    attributes.indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
                    [layout modifyAttributes:attributes];
                });
                
                it(@"sets the cell center (one position right of center)", ^{
                    expect(attributes.center).to.equal(CGPointMake(660,50));
                });
                
                it(@"sets the hidden attribute to NO", ^{
                    expect(attributes.hidden).to.equal(NO);
                });
            });
            
            context(@"hidden cell", ^{
                beforeEach(^{
                    attributes.indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
                    [layout modifyAttributes:attributes];
                });
                
                it(@"sets the cell center (two positions left of center)", ^{
                    expect(attributes.center).to.equal(CGPointMake(770, 50));
                });
                
                it(@"sets the cell to be invisible", ^{
                    expect(attributes.alpha).to.equal(0);
                    expect(attributes.hidden).to.equal(YES);
                });
            });
        });
    });
});

SpecEnd
