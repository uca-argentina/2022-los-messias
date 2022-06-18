Class {
	#name : #RandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> generateWithTheOrdinaryDistributionACollectionOfLockersOf: quantityOfLockers [

	| probabilityDistribution sequence lockers points |
	sequence := { 
		            (Parsec with: 2).
		            (Parsec with: 4).
		            (Parsec with: 8) }.
	points := { 
		          (PointProbability withX: LockerNoEffect new andY: 30).
		          (PointProbability withX: AtomicBombEffect new andY: 2).
		          (PointProbability
			           withX: (HyperJumpEffect with: sequence)
			           andY: 8).
		          (PointProbability
			           withX: (MoonWalkEffect with: 10)
			           andY: 10).
		          (PointProbability withX: SpeedUpEffect new andY: 20).
		          (PointProbability withX: WormHoleEffect new andY: 20).
		          (PointProbability withX: CardEffect new andY: 10) }.

	probabilityDistribution := ProbabilityDistribution with: points.
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: quantityOfLockers.
	^ lockers
]

{ #category : #boardDefinitionGeneratorTests }
RandomGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition probabilityDistribution points sequence |
	sequence := { 
		            (Parsec with: 2).
		            (Parsec with: 4).
		            (Parsec with: 8) }.
	points := { 
		          (PointProbability withX: LockerNoEffect new andY: 40).
		          (PointProbability withX: AtomicBombEffect new andY: 2).
		          (PointProbability
			           withX: (HyperJumpEffect with: sequence)
			           andY: 8).
		          (PointProbability
			           withX: (MoonWalkEffect with: 10)
			           andY: 10).
		          (PointProbability withX: SpeedUpEffect new andY: 20).
		          (PointProbability withX: WormHoleEffect new andY: 20) }.
	probabilityDistribution := ProbabilityDistribution with: points.
	boardDefinition := BoardDefinition
		                   with:
			                   ((RandomGenerator distributedBy:
				                     probabilityDistribution) 
				                    generateRandomObjectsWith: 10)
		                   and: (Parsec with: 100)
		                   played: 3.

	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition parsecsPerLocker equals: 0.1
]

{ #category : #cardGeneratorTests }
RandomGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	| probabilityDistribution points typeOfCards aDeck |
	typeOfCards := { 
		               SpeedCard new.
		               AccelerationCard new.
		               CancellationCard new.
		               RedoCard new.
		               RepeatCard new }.
	points := { 
		          (PointProbability withX: OverloadCard new andY: 100 / 6).
		          (PointProbability withX: SpeedCard new andY: 100 / 6).
		          (PointProbability
			           withX: AccelerationCard new
			           andY: 100 / 6).
		          (PointProbability
			           withX: CancellationCard new
			           andY: 100 / 6).
		          (PointProbability withX: RedoCard new andY: 100 / 6).
		          (PointProbability withX: RepeatCard new andY: 100 / 6) }.
	probabilityDistribution := ProbabilityDistribution with: points.

	aDeck := (RandomGenerator distributedBy: probabilityDistribution) 
		         generateRandomObjectsWith: 100000.

	self assert:
		((aDeck select: [ :i | i isMemberOf: OverloadCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((aDeck select: [ :i | i isMemberOf: SpeedCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((aDeck select: [ :i | i isMemberOf: AccelerationCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((aDeck select: [ :i | i isMemberOf: CancellationCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((aDeck select: [ :i | i isMemberOf: RedoCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((aDeck select: [ :i | i isMemberOf: RepeatCard ]) size
			 between: 10000
			 and: 20000)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfDifferentLockersWithCorrectProportion [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           100000.

	self assert:
		((lockers select: [ :i | i isMemberOf: WormHoleEffect ]) size
			 between: 10000
			 and: 30000).


	self assert:
		((lockers select: [ :i | i isMemberOf: MoonWalkEffect ]) size
			 between: 5000
			 and: 20000).

	self assert:
		((lockers select: [ :i | i isMemberOf: HyperJumpEffect ]) size
			 between: 4000
			 and: 16000).

	self assert:
		((lockers select: [ :i | i isMemberOf: AtomicBombEffect ]) size
			 between: 0
			 and: 4000).
	self assert:
		((lockers select: [ :i | i isMemberOf: LockerNoEffect ]) size
			 between: 20000
			 and: 40000).
	self assert:
		((lockers select: [ :i | i isMemberOf: CardEffect ]) size
			 between: 0
			 and: 20000)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfLockersWithDifferentInstancesOfEffects [

	| lockers probabilityDistribution |
	probabilityDistribution := ProbabilityDistribution with:
		                           { (PointProbability
			                            withX: MoonWalkEffect new
			                            andY: 100) }.
	lockers := (RandomGenerator distributedBy:
		            probabilityDistribution) generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers |
	lockers := self 
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           10.
	self assert: lockers size equals: 10
]
