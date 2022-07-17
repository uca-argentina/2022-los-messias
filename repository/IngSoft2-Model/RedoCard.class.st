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

{ #category : #'as yet unclassified' }
RedoCard >> createCardToRedoFrom: aCard [

	^ aCard class thrownBy: sourceShip
]

{ #category : #action }
RedoCard >> effectOn: aCardManager [

	cardToRedo := self fetchCardToRedoFrom: aCardManager.
	^ cardToRedo effectOn: aCardManager
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard = self ifTrue: [ aCard := aCard cardToRedo ].

	cardToRedo := self createCardToRedoFrom: aCard
]

{ #category : #initialization }
RedoCard >> initializeThrownBy: aSourceShip [

	sourceShip := aSourceShip
]
