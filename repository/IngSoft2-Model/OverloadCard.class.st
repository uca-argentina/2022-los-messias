Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyEffectTo: ship in: zathuraGame [

	zathuraGame addCardToBoard: (ActiveCard with: self appliedTo: {ship})
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
