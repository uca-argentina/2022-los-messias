Class {
	#name : #LockerFactoryTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LockerFactoryTest >> testLockerFactoryGeneratesACollectionOfDifferentLockers [

	| lockers |
	lockers := LockerFactory new generates: 100.

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: AtomicBomb ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: AtomicBomb ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: HyperJump ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: MoonWalk ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: SpeedUp ]).

	self assert:
		(lockers anySatisfy: [ :aLocker | aLocker isMemberOf: WormHole ])
]

{ #category : #tests }
LockerFactoryTest >> testLockerFactoryGeneratesACollectionOfSizeTen [

	| lockers |
	lockers := LockerFactory new generates: 10.

self assert: lockers size equals: 10
]
