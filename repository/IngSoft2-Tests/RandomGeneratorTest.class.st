Class {
	#name : #RandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'test - lockerGenerator' }
RandomGeneratorTest >> generateWithTheOrdinaryDistributionACollectionOfLockersOf: quantityOfLockers [

	| probabilityDistribution sequence lockers points |
	sequence := { 
		            (Parsec with: 2).
		            (Parsec with: 4).
		            (Parsec with: 8) }.
	points := { 
		          (ProbabilityPoint withX: LockerNoEffect new andY: 30).
		          (ProbabilityPoint withX: AtomicBombEffect new andY: 2).
		          (ProbabilityPoint
			           withX: (HyperJumpEffect with: sequence)
			           andY: 8).
		          (ProbabilityPoint
			           withX: (MoonWalkEffect with: 10)
			           andY: 10).
		          (ProbabilityPoint withX: SpeedUpEffect new andY: 20).
		          (ProbabilityPoint withX: WormHoleEffect new andY: 20).
		          (ProbabilityPoint withX: CardEffect new andY: 10) }.

	probabilityDistribution := ProbabilityDistribution with: points.
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: quantityOfLockers.
	^ lockers
]

{ #category : #'test - cardGenerator' }
RandomGeneratorTest >> generateWithTheOrdinaryDistributionADeckOf: quantityOfCards [ 
	| typeOfCards points probabilityDistribution |
	typeOfCards := { 
		               SpeedCard new.
		               AccelerationCard new.
		               CancellationCard new.
		               RedoCard new.
		               RepeatCard new }.
	points := { 
		          (ProbabilityPoint withX: OverloadCard new andY: 100 / 6).
		          (ProbabilityPoint withX: SpeedCard new andY: 100 / 6).
		          (ProbabilityPoint
			           withX: AccelerationCard new
			           andY: 100 / 6).
		          (ProbabilityPoint
			           withX: CancellationCard new
			           andY: 100 / 6).
		          (ProbabilityPoint withX: RedoCard new andY: 100 / 6).
		          (ProbabilityPoint withX: RepeatCard new andY: 100 / 6) }.
	probabilityDistribution := ProbabilityDistribution with: points.

	^(RandomGenerator distributedBy: probabilityDistribution) 
		         generateRandomObjectsWith: 100000.
]

{ #category : #'test - boardDefinitionGenerator' }
RandomGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition |
	boardDefinition := BoardDefinition
		                   with:
		                   (self 
			                    generateWithTheOrdinaryDistributionACollectionOfLockersOf:
			                    10)
		                   and: (Parsec with: 100)
		                   played: 3.

	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition unitPerLocker equals: 0.1
]

{ #category : #'test - cardGenerator' }
RandomGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	|aDeck |
	aDeck := self generateWithTheOrdinaryDistributionADeckOf: 100000.

	self assert: ((aDeck count: [ :card | card = OverloadCard new ])
			 between: 10000
			 and: 20000).
	self assert: ((aDeck count: [ :card | card = SpeedCard new ])
			 between: 10000
			 and: 20000).
	self assert: ((aDeck count: [ :card | card = AccelerationCard new ])
			 between: 10000
			 and: 20000).
	self assert: ((aDeck count: [ :card | card = CancellationCard new ])
			 between: 10000
			 and: 20000).
	self assert: ((aDeck count: [ :card | card = RedoCard new ])
			 between: 10000
			 and: 20000).
	self assert: ((aDeck count: [ :card | card = RepeatCard new ])
			 between: 10000
			 and: 20000)
]

{ #category : #'test - lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfDifferentLockersWithCorrectProportion [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           100000.

	self assert:
		((lockers select: [ :lockerEffect | 
			  lockerEffect = WormHoleEffect new ]) size
			 between: 10000
			 and: 30000).
	self assert:
		((lockers select: [ :lockerEffect | 
			  lockerEffect = MoonWalkEffect new ]) size
			 between: 5000
			 and: 20000).
	self assert: ((lockers select: [ :lockerEffect | 
			  lockerEffect = HyperJumpEffect new ]) size
			 between: 4000
			 and: 16000).
	self assert: ((lockers select: [ :lockerEffect | 
			  lockerEffect = AtomicBombEffect new ]) size between: 0 and: 4000).
	self assert:
		((lockers select: [ :lockerEffect | lockerEffect = LockerNoEffect new ]) size between: 20000 and: 40000).
	self assert:
		((lockers select: [ :lockerEffect | lockerEffect = CardEffect new ])
			 size between: 0 and: 20000)
]

{ #category : #'test - lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfLockersWithDifferentInstancesOfEffects [

	| lockers probabilityDistribution |
	probabilityDistribution := ProbabilityDistribution with:
		                           { (ProbabilityPoint
			                            withX: MoonWalkEffect new
			                            andY: 100) }.
	lockers := (RandomGenerator distributedBy:
		            probabilityDistribution) generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #'test - lockerGenerator' }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           10.
	self assert: lockers size equals: 10
]
