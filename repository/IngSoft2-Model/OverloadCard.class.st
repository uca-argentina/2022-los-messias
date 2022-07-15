Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
OverloadCard >> accept: aCardManager [

	^ [ :aShip | aCardManager applyEffectOf: self to: aShip ]
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]
