Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RepeatCard >> = aCard [

^(self class == aCard class).
]

{ #category : #actions }
RepeatCard >> applyEffectTo: aShip on: aZathuraGame by: sourceShip [

	aZathuraGame applyLastEffectOn: aShip with: self
]
