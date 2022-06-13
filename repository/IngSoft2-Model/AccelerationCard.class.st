Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyEffectToAllShipsIn: aZathuraGame [

	aZathuraGame changeRollOfAllShipsBy: 1.
	aZathuraGame  addCardToBoard: AccelerationCard new.
]

{ #category : #actions }
AccelerationCard >> disapplyEffectTo: aShip in: aZathuraGame [ 
	aZathuraGame changeRollOfAllShipsBy: -1.
]
