Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> withRemoving: aCard thrownBy: sourceShip [ 
	
	^ self new initializeWithRemoving: aCard thrownBy: sourceShip
]

{ #category : #action }
CancellationCard >> effectOn: aCardManager [

	^ [ :aShip | 
	  aCardManager removeFromCardsOnTable:
		  (ActiveCard with: cardToRemove appliedTo: aShip) ]
]

{ #category : #initialization }
CancellationCard >> initializeWithRemoving: aCard [

	cardToRemove := aCard
]

{ #category : #initialization }
CancellationCard >> initializeWithRemoving: aCard thrownBy: aSourceShip [  
	
	sourceShip := aSourceShip.
	cardToRemove := aCard
]
