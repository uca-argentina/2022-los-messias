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

{ #category : #initialization }
TurnEffectApplicator >> next [

	^ships next
]

{ #category : #private }
TurnEffectApplicator >> repeatTurn [

	ships undoNext
]

{ #category : #private }
TurnEffectApplicator >> reverseTheOrderOfTurns [
	
	ships reversed
]

{ #category : #initialization }
TurnEffectApplicator >> ships [

	^ships asArray
]

{ #category : #private }
TurnEffectApplicator >> skipTurnOfActualShip [

	ships next.
]
