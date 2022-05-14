Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> action: aCollectionOfShips triggeredBy: aShip on: aBoard [

	aBoard move: aShip by: -4
]
