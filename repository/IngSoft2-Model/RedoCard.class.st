Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'cardToRedo'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoCard >> = aCard [

	^ (aCard class == RedoCancellationCard) or: (self class = aCard class)
]

{ #category : #accessing }
RedoCard >> cardToRedo [ 

	^ cardToRedo 
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	aCard = self ifTrue: [ aCard := aCard cardToRedo ].
	cardToRedo := aCard
]

{ #category : #visiting }
RedoCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	| aCard |
	aCard := self fetchCardToRedoFrom: aCardManager.
	^ aCard returnsEffectOfCardThrownBy: sourceShip on: aCardManager
]
