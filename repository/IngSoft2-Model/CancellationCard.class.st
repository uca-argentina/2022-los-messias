Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> withRemoving: aCard [

	^ self new initializeWithRemoving: aCard
]

{ #category : #action }
CancellationCard >> accept: aCardManager [

	^ [ :aShip | 
	  aCardManager removeFromCardsOnTable:
		  (ActiveCard with: cardToRemove appliedTo: aShip) ]
]

{ #category : #initialization }
CancellationCard >> initializeWithRemoving: aCard [

	cardToRemove := aCard.
	typeOfCard := Instant new
]
