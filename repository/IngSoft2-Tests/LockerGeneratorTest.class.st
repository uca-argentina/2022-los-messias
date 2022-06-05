Class {
	#name : #LockerGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LockerGeneratorTest >> testLockerGeneratorGeneratesACollectionOfDifferentLockersWithCorrectProportion [

	| lockers effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
		           CardEffect new.
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 30. 2. 8. 10. 20. 10. 20 }.

	lockers := (RandomGenerator
		            with: effects
		            distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 100000.

	self assert:
		((lockers select: [ :i | i isMemberOf: WormHoleEffect ]) size
			 between: 10000
			 and: 30000).

	self assert:
		((lockers select: [ :i | i isMemberOf: SpeedUpEffect ]) size
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

{ #category : #tests }
LockerGeneratorTest >> testLockerGeneratorGeneratesACollectionOfLockersWithDifferentInstancesOfEffects [

	| lockers |
	lockers := (RandomGenerator
		            with: { (MoonWalkEffect with: 2) }
		            distributedBy: (ProbabilityDistribution with: { 100 })) 
		           generateRandomObjectsWith: 3.
	self deny: (lockers at: 2) identicalTo: (lockers at: 3)
]

{ #category : #tests }
LockerGeneratorTest >> testLockerGeneratorGeneratesACollectionOfSizeTen [

	| lockers effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 40. 2. 8. 10. 20. 20 }.
	lockers := (RandomGenerator
		            with: effects
		            distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 10.

	self assert: lockers size equals: 10
]
