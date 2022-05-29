Class {
	#name : #AtomicBombEffect,
	#superclass : #Locker,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombEffect >> applyFor: aShip on: aBoard [

	| allShips |
	allShips := aBoard allNameOfShips.
	allShips do: [ :ship | aBoard move: ship by: ((aBoard numberOfLockerOf: ship) * -1) ]
]
