Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
AccelerationCard >> accept: aCardManager [

	^ [ :aCollectionOfShips | 
	  aCardManager applyEffectOf: self to: aCollectionOfShips ]
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]

{ #category : #accesing }
AccelerationCard >> initialize [ 
	typeOfCard := Permanent new
]
