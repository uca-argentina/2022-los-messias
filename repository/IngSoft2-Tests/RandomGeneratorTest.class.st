Class {
	#name : #RandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #boardDefinitionGeneratorTests }
RandomGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition  probabilityDistribution points sequence |
	sequence := { Parsec with: 2. Parsec with: 4. Parsec with: 8 }.
	points := { 
		          (PointProbability withX: LockerNoEffect new andY: 40).
		          (PointProbability withX: AtomicBombEffect new andY: 2).
		          (PointProbability
			           withX: (HyperJumpEffect with: sequence )
			           andY: 8).
		          (PointProbability
			           withX: (MoonWalkEffect with: 10)
			           andY: 10).
		          (PointProbability withX: SpeedUpEffect new andY: 20).
		          (PointProbability withX: WormHoleEffect new andY: 20) }.
	probabilityDistribution := ProbabilityDistribution withPoints: points.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator distributedBy:
			                     probabilityDistribution))
		                   generatesWith: 10
		                   and: (Parsec with: 100)
		                   played: 3.

	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition parsecsPerLocker equals: 0.1
]

{ #category : #cardGeneratorTests }
RandomGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	| lockers probabilityDistribution cards  |
	cards := { 
		         OverloadCard new.
		         SpeedCard new.
		         AccelerationCard new.
		         CancellationCard new.
		         RedoCard new.
		         RepeatCard new }.
	"probabilityDistribution := ProbabilityDistribution
		                           withX: cards
		                           andY: { 
				                           (100 / 6).
				                           (100 / 6).
				                           (100 / 6).
				                           (100 / 6).
				                           (100 / 6).
				                           (100 / 6) }."

	lockers := (RandomGenerator distributedByRandom: cards) 
		           generateRandomObjectsWith: 100000.

	self assert:
		((lockers select: [ :i | i isMemberOf: OverloadCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: SpeedCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: AccelerationCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: CancellationCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((lockers select: [ :i | i isMemberOf: RedoCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: RepeatCard ]) size
			 between: 10000
			 and: 20000)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfDifferentLockersWithCorrectProportion [

	| lockers probabilityDistribution points sequence |
	sequence := { Parsec with: 2. Parsec with: 4. Parsec with: 8 }.
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
		
	probabilityDistribution := ProbabilityDistribution withPoints: points.

	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 100000.

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
	probabilityDistribution := ProbabilityDistribution withPoints:
		                           { (PointProbability
			                            withX: MoonWalkEffect new
			                            andY: 100) }.
	lockers := (RandomGenerator distributedBy:
		            probabilityDistribution) generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers probabilityDistribution points sequence |
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

	probabilityDistribution := ProbabilityDistribution withPoints: points.
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 10.

	self assert: lockers size equals: 10
]
