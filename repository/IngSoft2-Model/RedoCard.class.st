Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'cardToRedo'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> thrownBy: aSourceShip [

	^self new initializeThrownBy: aSourceShip
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ (aCard class == RedoCancellationCard) or: (self class = aCard class)
]

{ #category : #accessing }
RedoCard >> cardToRedo [ 

	^ cardToRedo 
]

{ #category : #action }
RedoCard >> effectOn: aCardManager [

	self fetchCardToRedoFrom: aCardManager.
	^ cardToRedo effectOn: aCardManager
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard = self ifTrue: [ aCard := aCard cardToRedo ].
	
	cardToRedo := (aCard class) thrownBy: sourceShip 
]

{ #category : #initialization }
RedoCard >> initializeThrownBy: aSourceShip [

	sourceShip := aSourceShip
]
