Class {
	#name : #LockerFactoryTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LockerFactoryTest >> testLockerFactoryGeneratesABoardStructure [

	| boardStructure |
	boardStructure := LockerFactory new
		                  generatesWith: 10
		                  and: 100
		                  played: 3.

	self assert: boardStructure lockers size equals: 10.
	self assert: boardStructure laps equals: 3.
	self assert: boardStructure parsecsPerLocker equals: 0.1.
]

{ #category : #tests }
LockerFactoryTest >> testLockerFactoryGeneratesACollectionOfDifferentLockers [

	| lockers boardStructure |
	boardStructure := LockerFactory new
		                  generatesWith: 1000
		                  and: 10000
		                  played: 3.
	lockers := boardStructure lockers.

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: AtomicBombEffect ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: AtomicBombEffect ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: HyperJumpEffect ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: MoonWalkEffect ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: SpeedUpEffect ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: WormHoleEffect ])
]

{ #category : #tests }
LockerFactoryTest >> testLockerFactoryGeneratesACollectionOfSizeTen [

	| lockers boardStructure |
	boardStructure := LockerFactory new
		                  generatesWith: 10
		                  and: 100
		                  played: 3.
	lockers := boardStructure lockers.

	self assert: lockers size equals: 10
]
