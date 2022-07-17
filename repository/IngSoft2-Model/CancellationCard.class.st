Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> with: aCard thrownBy: sourceShip [ 
	
	^ self new initializeWith: aCard thrownBy: sourceShip
]

{ #category : #action }
CancellationCard >> effectOn: aCardApplicator [

	^ [ :aShip | 
	  aCardApplicator removeFromCardsOnTable:
		  (ActiveCard with: cardToRemove appliedTo: aShip) ]
]

{ #category : #initialization }
CancellationCard >> initializeWith: aCard thrownBy: aSourceShip [  
	
	sourceShip := aSourceShip.
	cardToRemove := aCard
]
