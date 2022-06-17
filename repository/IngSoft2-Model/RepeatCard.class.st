Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> applyEffectTo: aShip in: aZathuraGame by: sourceShip [ 
	aZathuraGame applyLastEffectOn: aShip.
]
