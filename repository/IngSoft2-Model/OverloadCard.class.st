Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> addIn: zathuraGame appliedTo: ship [

	zathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: { ship })
]

{ #category : #action }
OverloadCard >> applyEffectTo: ship on: aCardManager by: sourceShip [

	aCardManager throw: self.
	self assertIsYourTurn: sourceShip in: aCardManager.
	self addIn: aCardManager appliedTo: ship
]

{ #category : #action }
OverloadCard >> assertIsYourTurn: aShip in: aCardManager [

	(aCardManager isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
