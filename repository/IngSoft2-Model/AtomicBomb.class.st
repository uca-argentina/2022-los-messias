Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBomb >> action: aShip on: aBoard [

	| allShips |
	allShips := aBoard AllNameOfShips.
	allShips do: [ :ship | aBoard move: ship by: ((aBoard numberOfLockerOf: ship) * -1) ]
]
