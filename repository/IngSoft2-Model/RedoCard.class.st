Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'cardToRedo',
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> thrownBy: aSourceShip to: destinationShip [

	^ self new initializeThrownBy: aSourceShip to: destinationShip
]

{ #category : #accessing }
RedoCard >> cardToRedo [ 

	^ cardToRedo 
]

{ #category : #action }
RedoCard >> createCardToRedoFrom: aCard [

	^ aCard class thrownBy: sourceShip to: destinationShip
]

{ #category : #action }
RedoCard >> effectOn: aCardApplicator [

	cardToRedo := self fetchCardToRedoFrom: aCardApplicator.
	^ cardToRedo effectOn: aCardApplicator
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardApplicator [

	| aCard |
	aCard := aCardApplicator lastCardThrownOnTheGame.
	aCard = self ifTrue: [ aCard := aCard cardToRedo ].

	^ self createCardToRedoFrom: aCard
]

{ #category : #initialization }
RedoCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip 
]
