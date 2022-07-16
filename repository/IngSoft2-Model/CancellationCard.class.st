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

{ #category : #initialization }
CancellationCard >> initializeWithRemoving: aCard [

	cardToRemove := aCard
]

{ #category : #action }
CancellationCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	^ [ :aShip | 
	  aCardManager removeFromCardsOnTable:
		  (ActiveCard with: cardToRemove appliedTo: aShip) ]
]
