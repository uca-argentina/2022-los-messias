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
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 40. 2. 8. 10. 20. 20 }.

	lockers := (LockerGenerator
		            with: effects
		            distributedBy: probabilityDistribution) 
		           generateRandomLockersWith: 100000.

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
			 between: 30000
			 and: 50000)
]

{ #category : #tests }
LockerGeneratorTest >> testLockerGeneratorGeneratesACollectionOfLockersWithDifferentInstancesOfEffects [

	| lockers |
	lockers := (LockerGenerator
		            with: { (MoonWalkEffect with: 2) }
		            distributedBy: (ProbabilityDistribution with: { 100 })) 
		           generateRandomLockersWith: 3.
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
	lockers := (LockerGenerator
		            with: effects
		            distributedBy: probabilityDistribution) 
		           generateRandomLockersWith: 10.

	self assert: lockers size equals: 10
]
