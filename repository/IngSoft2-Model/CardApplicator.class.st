Class {
	#name : #CardApplicator,
	#superclass : #Object,
	#instVars : [
		'cardManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardApplicator class >> with: aCardManager [

	^ self new initializeWith: aCardManager
]

{ #category : #initalization }
CardApplicator >> initializeWith: aCardManager [
	cardManager := aCardManager

]

{ #category : #action }
CardApplicator >> throws: aCancellationCard removing: aCard from: sourceShip [

	cardManager throws: aCancellationCard removing: aCard from: sourceShip
]

{ #category : #action }
CardApplicator >> throws: aCard to: destinationShip from: sourceShip [

	cardManager throws: aCard to: destinationShip from: sourceShip
]

{ #category : #action }
CardApplicator >> throws: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	cardManager throws: cancellationCard to: destinationShip removing: aCard from: sourceShip
]

{ #category : #action }
CardApplicator >> throws: aCard toAllShipsFrom: aShip [

	cardManager throws: aCard toAllShipsFrom: aShip
]
