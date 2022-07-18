Class {
	#name : #RedoCardWithACard,
	#superclass : #RedoCard,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCardWithACard class >> with: aCard thrownBy: aSourceShip [

	^ self new initializeWith: aCard thrownBy: aSourceShip
]

{ #category : #comparing }
RedoCardWithACard >> = aCard [
	^ RedoCard = aCard class
]

{ #category : #action }
RedoCardWithACard >> createCardToRedoFrom: aCard [

	^ aCard class with: card thrownBy: sourceShip

]

{ #category : #initialization }
RedoCardWithACard >> initializeWith: aCard thrownBy: aSourceShip [

	card := aCard.
	sourceShip := aSourceShip 
]
