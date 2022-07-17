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

{ #category : #accessing }
RedoCard >> cardToRedo [ 

	^ cardToRedo 
]

{ #category : #action }
RedoCard >> createCardToRedoFrom: aCard [

	^ aCard class thrownBy: sourceShip
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
RedoCard >> initializeThrownBy: aSourceShip [

	sourceShip := aSourceShip
]
