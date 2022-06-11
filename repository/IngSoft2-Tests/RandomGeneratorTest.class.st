Class {
	#name : #RandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #boardDefinitionGeneratorTests }
RandomGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           SpeedUpEffect new.
		           WormHoleEffect new }.
	probabilityDistribution := ProbabilityDistribution
		                           withX: effects
		                           andY: { 40. 2. 8. 10. 20. 20 }.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator distributedBy:
			                     probabilityDistribution))
		                   generatesWith: 10
		                   and: 100
		                   played: 3.

	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition parsecsPerLocker equals: 0.1
]

{ #category : #cardGeneratorTests }
RandomGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	| lockers probabilityDistribution cards generator |
	cards := { 
		         OverloadCard new.
		         SpeedCard new.
		         AccelerationCard new.
		         CancellationCard new.
		         RedoCard new.
		         RepeatCard new }.
	probabilityDistribution := ProbabilityDistribution withX: cards andY:  { 
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6) }.

	lockers := (RandomGenerator
		            distributedBy: probabilityDistribution) 
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

	| lockers effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
					  SpeedUpEffect new. 
		           CardEffect new }.
	probabilityDistribution := ProbabilityDistribution
		                           withX: effects
		                           andY: { 30. 2. 8. 10. 20. 20 . 10 }.

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

	| lockers |
	lockers := (RandomGenerator distributedBy:
		            (ProbabilityDistribution withX: { MoonWalkEffect new } andY: { 100 })) 
		           generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #lockerGeneratorTests }
RandomGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution withX: effects  andY:{ 40. 2. 8. 10. 20. 20 }.
		                           .
	lockers := (RandomGenerator distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 10.

	self assert: lockers size equals: 10
]
