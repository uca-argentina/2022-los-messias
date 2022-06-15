Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyEffectTo: ship in: zathuraGame [

	zathuraGame changeRollOf: ship by: -2.
	zathuraGame addCardToBoard: (ActiveCard with: self appliedTo: {ship})
]
