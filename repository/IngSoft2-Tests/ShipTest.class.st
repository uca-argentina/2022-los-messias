Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testShipPlaysAndAdvancesNPositions [

| n aShip die1 die2 die3 diceCup |
aShip := Ship with: 2.
die1 := LoadedDie with: 4.
die2 := LoadedDie with: 7.
die3 := LoadedDie with: 2.

diceCup := DiceCup withAll: { 
			        die1.
			        die2.
			        die3 }.
aShip playsWith: diceCup.

self assert: aShip isInPosition equals: 13.
]

{ #category : #tests }
ShipTest >> testShipRollsNAndAdvancesNPositions [

| aShip n |
aShip := Ship with: 1.
n:= 5.
aShip advances: n.

self assert: aShip isInPosition equals: n

]
