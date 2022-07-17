Class {
	#name : #RedoWithACardAsInternCollaborator,
	#superclass : #RedoCard,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoWithACardAsInternCollaborator class >> with: aCard thrownBy: aSourceShip [

	^ self new initializeWith: aCard thrownBy: aSourceShip
]

{ #category : #comparing }
RedoWithACardAsInternCollaborator >> = aCard [
	^ RedoCard = aCard class
]

{ #category : #action }
RedoWithACardAsInternCollaborator >> createCardToRedoFrom: aCard [

	^ aCard class with: card thrownBy: sourceShip

]

{ #category : #initialization }
RedoWithACardAsInternCollaborator >> initializeWith: aCard thrownBy: aSourceShip [

	card := aCard.
	sourceShip := aSourceShip 
]
