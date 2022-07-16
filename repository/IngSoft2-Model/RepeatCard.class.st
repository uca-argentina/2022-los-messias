Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> accept: aCardManager [

	^ [ :aCollectionOfShip | aCardManager applyLastEffectOn: aCollectionOfShip first ]
]

{ #category : #initialization }
RepeatCard >> initialize [

	typeOfCard := Instant new
]
