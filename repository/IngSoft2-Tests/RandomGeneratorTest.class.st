Class {
	#name : #RandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'test-lockerGenerator' }
RandomGeneratorTest >> assertAmountOf: wormhole isBetween: lowValueWormhole and: topValueWormhole in: lockers [

	self assert: ((lockers count: [ :i | i = wormhole ])
			 between: lowValueWormhole
			 and: topValueWormhole)
]

{ #category : #asserting }
RandomGeneratorTest >> assertCard: aCard HasCorrectAmountIn: aDeck [

	self
		assertAmountOf: aCard
		isBetween: 10000
		and: 20000
		in: aDeck
]

{ #category : #'test-cardGenerator' }
RandomGeneratorTest >> createPointsWithEqualProbabilityFrom: typeOfCards [

	| amountOfCards points |
	points := OrderedCollection new.
	amountOfCards := typeOfCards size.
	typeOfCards do: [ :card | 
		points add: (ProbabilityPoint
				 initializeEvent: card
				 withProbability: 100 / amountOfCards) ].
	^ points
]

{ #category : #'test-lockerGenerator' }
RandomGeneratorTest >> generateWithTheOrdinaryDistributionACollectionOfLockersOf: quantityOfLockers [

	| probabilityDistribution sequence lockers points |
	sequence := { 
		            (Parsec with: 2).
		            (Parsec with: 4).
		            (Parsec with: 8) }.
	points := { 
		          (ProbabilityPoint initializeEvent: LockerNoEffect new withProbability: 30).
		          (ProbabilityPoint initializeEvent: AtomicBombEffect new withProbability: 2).
		          (ProbabilityPoint
			           initializeEvent: (HyperJumpEffect with: sequence)
			           withProbability: 8).
		          (ProbabilityPoint
			           initializeEvent: (MoonWalkEffect with: 10)
			           withProbability: 10).
		          (ProbabilityPoint initializeEvent: SpeedUpEffect new withProbability: 20).
		          (ProbabilityPoint initializeEvent: WormHoleEffect new withProbability: 20).
		          (ProbabilityPoint initializeEvent: CardEffect new withProbability: 10) }.

	probabilityDistribution := ProbabilityDistribution with: points.
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: quantityOfLockers.
	^ lockers
]

{ #category : #'test-boardDefinitionGenerator' }
RandomGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition    |
	
	boardDefinition := BoardDefinition
		                   with:
		                   (self 
			                    generateWithTheOrdinaryDistributionACollectionOfLockersOf:
			                    10)
		                   and: (Parsec with: 100)
		                   played: 3.

	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition distancePerLockerAsParsecs equals: 0.1
]

{ #category : #'test-cardGenerator' }
RandomGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	| probabilityDistribution typeOfCards aDeck |
	typeOfCards := { 
		               OverloadCard new.
		               SpeedCard new.
		               AccelerationCard new.
		               CancellationCard new.
		               RedoCard new.
		               RepeatCard new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           (self 
			                            createPointsWithEqualProbabilityFrom:
			                            typeOfCards).
	aDeck := (RandomGenerator distributedBy: probabilityDistribution) 
		         generateRandomObjectsWith: 100000.
	self
		assertCard: OverloadCard new HasCorrectAmountIn: aDeck.
	self
		assertCard: SpeedCard new HasCorrectAmountIn: aDeck .
	self assertCard: AccelerationCard new HasCorrectAmountIn: aDeck.
	self assertCard: CancellationCard new HasCorrectAmountIn: aDeck.
	self assertCard: RedoCard new HasCorrectAmountIn: aDeck.
	self assertCard: RepeatCard new HasCorrectAmountIn: aDeck
]

{ #category : #'test-lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfDifferentLockersWithCorrectProportion [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           100000.
	self
		assertAmountOf: WormHoleEffect new
		isBetween: 10000
		and: 30000
		in: lockers.

	self
		assertAmountOf: MoonWalkEffect new
		isBetween: 5000
		and: 20000
		in: lockers.

	self
		assertAmountOf: HyperJumpEffect new
		isBetween: 4000
		and: 16000
		in: lockers.

	self
		assertAmountOf: AtomicBombEffect new
		isBetween: 0
		and: 4000
		in: lockers.

	self
		assertAmountOf: LockerNoEffect new
		isBetween: 20000
		and: 40000
		in: lockers.

	self
		assertAmountOf: CardEffect new
		isBetween: 0
		and: 20000
		in: lockers.

]

{ #category : #'test-lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfLockersWithDifferentInstancesOfEffects [

	| lockers probabilityDistribution |
	probabilityDistribution := ProbabilityDistribution with:
		                           { (ProbabilityPoint
			                            initializeEvent: MoonWalkEffect new
			                            withProbability: 100) }.
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #'test-lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           10.
	self assert: lockers size equals: 10
]
