Class {
	#name : #LockerFactory,
	#superclass : #Object,
	#instVars : [
		'lockers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
LockerFactory >> generateLocker: aProbability [

	| locker |
	aProbability <= 2 ifTrue: [ locker := AtomicBomb new ].
	(aProbability > 2 and: [ aProbability <= 10 ]) ifTrue: [ 
		locker := HyperJump with: { 15. 20. 35 } ].
	(aProbability > 10 and: [ aProbability <= 20 ]) ifTrue: [ 
		locker := MoonWalk with: 10 atRandom ].
	(aProbability > 20 and: [ aProbability <= 40 ]) ifTrue: [ 
		locker := SpeedUp new ].
	(aProbability > 40 and: [ aProbability <= 60 ]) ifTrue: [ 
		locker := WormHole new ].
	(aProbability > 60 and: [ aProbability <= 100 ]) ifTrue: [ 
		locker := LockerNoEffect new ].
	^ locker
]

{ #category : #generating }
LockerFactory >> generates: numberOfLockers [

	lockers := OrderedCollection new.
	lockers add: LockerNoEffect new.
	2 to: numberOfLockers  do: [ :number | 
	lockers add: (self generateLocker: 100 atRandom) ].
	^ lockers
]

{ #category : #generating }
LockerFactory >> generatesWith: aNumberOfLockers and: parsecs played: laps [ 
	^ BoardStructure with: (self generates: aNumberOfLockers) and: parsecs played: laps
]
