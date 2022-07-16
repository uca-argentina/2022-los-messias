Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
SpeedCard >> accept: aCardManager [

	^ [ :aShip | aCardManager applyEffectOf: self to: aShip ]
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]

{ #category : #initialization }
SpeedCard >> initialize [

	typeOfCard := Permanent new
]
