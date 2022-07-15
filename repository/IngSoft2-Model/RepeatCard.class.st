Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> accept: aCardManager [

	^ [:aShip | aCardManager applyLastEffectOn: aShip ]
]
