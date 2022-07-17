Class {
	#name : #RedoCancellationCard,
	#superclass : #RedoCard,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCancellationCard class >> withRemoving: aCard [ 
	
	^ self new initializeWithRemoving: aCard
]

{ #category : #'instance creation' }
RedoCancellationCard class >> withRemoving: aCard thrownBy: aSourceShip [

	^ self new initializeWithRemoving: aCard thrownBy: aSourceShip
]

{ #category : #action }
RedoCancellationCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard = self ifTrue: [ aCard := aCard cardToRedo ].

	cardToRedo := aCard class withRemoving: cardToRemove thrownBy: sourceShip 
]

{ #category : #initialization }
RedoCancellationCard >> initializeWithRemoving: aCard [

	cardToRemove := aCard.
]

{ #category : #initialization }
RedoCancellationCard >> initializeWithRemoving: aCard thrownBy: aSourceShip [

	cardToRemove := aCard.
	sourceShip := aSourceShip 
]
