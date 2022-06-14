Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyEffectTo: ship in: zathuraGame [

	zathuraGame changeRollOf: ship by: 1.
	zathuraGame addCardToBoard: (ActiveCard with: self appliedTo: ship)
]
