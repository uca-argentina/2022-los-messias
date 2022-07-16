Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
PermanentCard >> returnsEffectOf: aCard thrownBy: sourceShip on: aCardManager [

	aCardManager assertIsYourTurn: sourceShip.
	^ [ :aCollectionOfShips | 
	  aCardManager addCardToTable: (ActiveCard with: aCard appliedTo: aCollectionOfShips)]
]
