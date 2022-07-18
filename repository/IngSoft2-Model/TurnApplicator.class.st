Class {
	#name : #TurnApplicator,
	#superclass : #Object,
	#instVars : [
		'ships',
		'double'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnApplicator class >> with: ships [
	^self new initializeWith: ships
]

{ #category : #cardEffect }
TurnApplicator >> checkAndPlayDoubleTurn [

	(double == true) ifTrue: [ 
		ships undoNext.
		double := false.]
]

{ #category : #cardEffect }
TurnApplicator >> doubleTurn [

	double := true
]

{ #category : #initialization }
TurnApplicator >> initializeWith: aCollectionOfShips [

	ships := aCollectionOfShips asOrderedCollection asSequence.
	double := false
]

{ #category : #accessing }
TurnApplicator >> isTurnOf: aShip [

	^ (ships first = aShip)
]

{ #category : #action }
TurnApplicator >> next [

	| ship |
	ship := ships next.
	self checkAndPlayDoubleTurn.
	^ ship
]

{ #category : #cardEffect }
TurnApplicator >> reverseTheOrderOfTurns [
	
	ships reversed
]

{ #category : #accessing }
TurnApplicator >> ships [

	^ships asArray
]

{ #category : #cardEffect }
TurnApplicator >> skipTurnOfActualShip [

	ships next.
]
