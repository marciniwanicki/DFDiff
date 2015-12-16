//
// Created by Marcin Iwanicki on 13/12/2015.
// Copyright (c) 2015 Marcin Iwanicki. All rights reserved.
//

#import "DFMove.h"
#import "DFArrayDiff.h"
#import "DFSimpleObject.h"
#import "DFDelete.h"
#import "DFInsert.h"


SpecBegin(DFArrayDiff)

    __block DFDiff *sut;

    __block NSArray <id <DFDiffId>> *origin;
    __block NSArray <id <DFDiffId>> *source;

    NSArray <id <DFDiffId>> *(^sampleObjectsFromString)(NSString *) = ^NSArray <id <DFDiffId>> *(NSString *string) {
        NSArray *objects = [string componentsSeparatedByString:@" "];
        NSMutableArray *diffIds = [NSMutableArray array];
        for (NSString *object in objects) {
            [diffIds addObject:DFMakeSimpleObject(object)];
        }
        return diffIds;
    };

    describe(@"initialized with the same source and origin arrays", ^{

        it(@"should generate empty DFDiff object for non empty arrays", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B C D E");

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });

        it(@"should generate empty DFDiff object for nil parameters", ^{
            // when
            sut = [[DFArrayDiff alloc] initWithSource:nil origin:nil];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes.count).to.equal(0);
        });
    });

    describe(@"initialized with deleted first object", ^{

        it(@"should generate only single delete", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes).to.equal(@[[DFDelete deleteWithIndex:0]]);
        });

        it(@"should create source properly", ^{
            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with deleted first, middle and last object", ^{

        it(@"should generate three deletes", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes).to.equal(@[
                    [DFDelete deleteWithIndex:0],
                    [DFDelete deleteWithIndex:2],
                    [DFDelete deleteWithIndex:4]]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with all objects deleted", ^{

        it(@"should generate deletes for all objects", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = @[];

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes).to.equal(@[
                    [DFDelete deleteWithIndex:0],
                    [DFDelete deleteWithIndex:1],
                    [DFDelete deleteWithIndex:2],
                    [DFDelete deleteWithIndex:3],
                    [DFDelete deleteWithIndex:4]]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = @[];

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with inserted single object at index 0", ^{

        it(@"should generate single insert", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"X A B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts).to.equal(@[[DFInsert insertWithIndex:0 value:DFMakeSimpleObject(@"X")]]);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"X A B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with inserted single object in the middle", ^{

        it(@"should generate single insert", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B X C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts).to.equal(@[[DFInsert insertWithIndex:2 value:DFMakeSimpleObject(@"X")]]);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B X C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with inserted single object in the end", ^{

        it(@"should generate single insert", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B C D E X");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts).to.equal(@[[DFInsert insertWithIndex:5 value:DFMakeSimpleObject(@"X")]]);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A B C D E X");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with one deleted and one inserted object at the same index", ^{

        it(@"should generate single insert and single delete", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"X B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.equal(0);
            expect(sut.inserts).to.equal(@[[DFInsert insertWithIndex:0 value:DFMakeSimpleObject(@"X")]]);
            expect(sut.deletes).to.equal(@[[DFDelete deleteWithIndex:0]]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"X B C D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with one deleted and one inserted object", ^{

        it(@"should generate single insert and single delete and no moves", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B C X D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves).to.equal(@[[DFMove moveWithFromIndex:2 toIndex:1]]);
            expect(sut.inserts).to.equal(@[[DFInsert insertWithIndex:2 value:DFMakeSimpleObject(@"X")]]);
            expect(sut.deletes).to.equal(@[[DFDelete deleteWithIndex:0]]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B C X D E");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });


    describe(@"initialized with one few and few inserted object", ^{

        it(@"should generate few inserts and few deletes", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B D X Z Y E P");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves).to.equal(@[
                    [DFMove moveWithFromIndex:3 toIndex:1]
            ]);
            expect(sut.inserts).to.equal(@[
                    [DFInsert insertWithIndex:2 value:DFMakeSimpleObject(@"X")],
                    [DFInsert insertWithIndex:3 value:DFMakeSimpleObject(@"Z")],
                    [DFInsert insertWithIndex:4 value:DFMakeSimpleObject(@"Y")],
                    [DFInsert insertWithIndex:6 value:DFMakeSimpleObject(@"P")]
            ]);
            expect(sut.deletes).to.equal(@[
                    [DFDelete deleteWithIndex:0],
                    [DFDelete deleteWithIndex:2]
            ]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"B X D Z Y E P");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with single move", ^{

        /**
         * Actually it would be great to guarantee a single move then.
         */
        it(@"does not guarantee a single move is generated", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A E B C D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.beGreaterThan(1);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A E B C D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized with single move", ^{

        /**
         * Actually it would be great to guarantee a single move then.
         */
        it(@"does not guarantee a single move is generated", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A E B C D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves.count).to.beGreaterThan(1);
            expect(sut.inserts.count).to.equal(0);
            expect(sut.deletes.count).to.equal(0);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E");
            source = sampleObjectsFromString(@"A E B C D");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

    describe(@"initialized complex manipulations", ^{

        it(@"should generate single move", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E F G H");
            source = sampleObjectsFromString(@"X G D Y A");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect(sut.moves).to.equal(@[
                    [DFMove moveWithFromIndex:0 toIndex:4],
                    [DFMove moveWithFromIndex:3 toIndex:2],
                    [DFMove moveWithFromIndex:6 toIndex:1],
            ]);
            expect(sut.inserts).to.equal(@[
                    [DFInsert insertWithIndex:0 value:DFMakeSimpleObject(@"X")],
                    [DFInsert insertWithIndex:3 value:DFMakeSimpleObject(@"Y")],
            ]);
            expect(sut.deletes).to.equal(@[
                    [DFDelete deleteWithIndex:1],
                    [DFDelete deleteWithIndex:2],
                    [DFDelete deleteWithIndex:4],
                    [DFDelete deleteWithIndex:5],
                    [DFDelete deleteWithIndex:7]
            ]);
        });

        it(@"should create source properly", ^{
            // given
            origin = sampleObjectsFromString(@"A B C D E F G H");
            source = sampleObjectsFromString(@"X G D Y A");

            // when
            sut = [[DFArrayDiff alloc] initWithSource:source origin:origin];

            // then
            expect([sut applyTo:origin]).to.equal(source);
        });
    });

SpecEnd