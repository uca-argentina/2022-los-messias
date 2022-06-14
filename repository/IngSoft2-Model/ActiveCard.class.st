Class {
	#name : #ActiveCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ActiveCard class >> with: card appliedTo: aShip [

	^self new initializeWith: card appliedTo: aShip
]

{ #category : #comparing }
ActiveCard >> = activeCard [
	^(self ship = activeCard ship)
]
