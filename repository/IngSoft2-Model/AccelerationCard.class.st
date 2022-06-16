Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> = card [

	^(self hasEqualClass: card)
]

{ #category : #action }
AccelerationCard >> applyEffectToAllShipsIn: aZathuraGame [

	aZathuraGame addCardToTable:
		(ActiveCard with: self appliedTo: (aZathuraGame ships))
]

{ #category : #action }
AccelerationCard >> card [
	^ self
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]
