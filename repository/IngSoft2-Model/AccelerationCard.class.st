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

	aZathuraGame changeRollOfAllShipsBy: 1.
	aZathuraGame addCardToBoard: self
]

{ #category : #actions }
AccelerationCard >> disapplyEffectIn: aZathuraGame [

	aZathuraGame removeFromCardsOnTable: self.
	aZathuraGame changeRollOfAllShipsBy: -1
]
