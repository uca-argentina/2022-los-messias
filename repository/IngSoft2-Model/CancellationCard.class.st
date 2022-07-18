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

	^ self new
		  initializeWith: aCard
		  thrownBy: sourceShip
]

{ #category : #action }
CancellationCard >> effectOn: aCardApplicator [

	| destinationShip |
	destinationShip :=  {cardToRemove destinationShip} .
	destinationShip = {'allShips'} ifTrue: [ 
		destinationShip := aCardApplicator ships ].
	aCardApplicator removeFromCardsOnTable:
		(ActiveCard with: cardToRemove appliedTo: destinationShip)
]

{ #category : #initialization }
CancellationCard >> initializeWith: aCard thrownBy: aSourceShip [

	sourceShip := aSourceShip.
	cardToRemove := aCard
]
