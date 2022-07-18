Class {
	#name : #TurnEffectApplicator,
	#superclass : #Object,
	#instVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnEffectApplicator class >> with: ships [
	^self new initializeWith: ships
]

{ #category : #initialization }
TurnEffectApplicator >> initializeWith: aCollectionOfShips [

	ships := aCollectionOfShips asOrderedCollection asSequence
]

{ #category : #accessing }
TurnEffectApplicator >> isTurnOf: aShip [

	^ (ships first = aShip)
]

{ #category : #action }
TurnEffectApplicator >> next [

	^ships next
]

{ #category : #cardEffect }
TurnEffectApplicator >> repeatTurn [

	ships undoNext
]

{ #category : #cardEffect }
TurnEffectApplicator >> reverseTheOrderOfTurns [
	
	ships reversed
]

{ #category : #accessing }
TurnEffectApplicator >> ships [

	^ships asArray
]

{ #category : #cardEffect }
TurnEffectApplicator >> skipTurnOfActualShip [

	ships next.
]
