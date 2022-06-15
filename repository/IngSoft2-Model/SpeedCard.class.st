Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyEffectTo: ship in: zathuraGame [

	"zathuraGame changeRollOf: ship by: 1."

	| aaa |
	aaa := ActiveCard with: self appliedTo: ship.
	zathuraGame addCardToBoard: (ActiveCard with: self appliedTo: {ship})
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]
