Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> applyEffectTo: aShip on: aCardManager by: sourceShip [

	aCardManager applyLastEffectOn: aShip
]
