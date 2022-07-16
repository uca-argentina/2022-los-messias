Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> returnsEffectOfCardThrownBy: sourceShip on: aCardManager [

	^ [ :aCollectionOfShip | aCardManager applyLastEffectOn: aCollectionOfShip first ]
]
