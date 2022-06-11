Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyEffectTo: ship in: zathuraGame [
	zathuraGame addCardToBoard: self.
	zathuraGame changeRollOf: ship by: -2
]

{ #category : #action }
OverloadCard >> disapplyEffectTo: ship in: zathuraGame [

	zathuraGame addCardToBoard: self.
	zathuraGame changeRollOf: ship by: 2
]
