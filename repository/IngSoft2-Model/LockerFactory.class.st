Class {
	#name : #LockerFactory,
	#superclass : #Object,
	#instVars : [
		'parsecsBoard'
	],
	#classInstVars : [
		'parsecsBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
LockerFactory >> createHyperJump [

	^ HyperJump with: { 
			  (parsecsBoard // 4 to: parsecsBoard // 2) atRandom.
			  (parsecsBoard // 6 to: parsecsBoard // 4) atRandom.
			  (1 to: parsecsBoard // 6) atRandom }
]

{ #category : #generating }
LockerFactory >> createLockerWith: aProbability [

	| locker |
	aProbability <= 2 ifTrue: [ locker := AtomicBomb new ].
	(aProbability > 2 and: [ aProbability <= 10 ]) ifTrue: [ 
		locker := self createHyperJump ].
	(aProbability > 10 and: [ aProbability <= 20 ]) ifTrue: [ 
		locker := self createMoonWalk ].
	(aProbability > 20 and: [ aProbability <= 40 ]) ifTrue: [ 
		locker := SpeedUp new ].
	(aProbability > 40 and: [ aProbability <= 60 ]) ifTrue: [ 
		locker := WormHole new ].
	(aProbability > 60 and: [ aProbability <= 100 ]) ifTrue: [ 
		locker := LockerNoEffect new ].
	^ locker
]

{ #category : #generating }
LockerFactory >> createMoonWalk [

	^ MoonWalk with: 10 atRandom
]

{ #category : #generating }
LockerFactory >> generateRandomLockersWith: numberOfLockers [

	| lockers |
	lockers := OrderedCollection new.
	lockers add: LockerNoEffect new.
	2 to: numberOfLockers do: [ :number | 
	lockers add: (self createLockerWith: 100 atRandom) ].
	^ lockers
]

{ #category : #generating }
LockerFactory >> generates: numberOfLockers [

	"parsecsBoard = 0 ifFalse: [ parsecsBoard := numberOfLockers * 10 ]."
	^ self generateRandomLockersWith: numberOfLockers
]

{ #category : #generating }
LockerFactory >> generatesWith: aNumberOfLockers and: parsecs played: laps [

	parsecsBoard := parsecs.
	^ BoardStructure
		  with: (self generates: aNumberOfLockers)
		  and: parsecs
		  played: laps
]
