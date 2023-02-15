Class {
	#name : #CardThrower,
	#superclass : #Object,
	#instVars : [
		'cardHands',
		'zathura'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CardThrower class >> createNewWith: cardHands in: aZathuraGame [

	^ self new createNewWith: cardHands in: aZathuraGame .
]

{ #category : #intialization }
CardThrower >> createNewWith: aGroupOfCardHands in: aZathuraGame [ 
		cardHands := aGroupOfCardHands.
	zathura := aZathuraGame.
]

{ #category : #throwin }
CardThrower >> throw: aCancellationCard to: destinationShip removing: aCard from: sourceShip [ 
	(cardHands cardHandOf: sourceShip)
		throw: aCancellationCard
		to: destinationShip
		removing: aCard
		on: zathura .
]

{ #category : #throwing }
CardThrower >> throw: anAccelerationCard toAllShipsFrom: aShip [ 
	| cardHand |
	cardHand := cardHands cardHandOf: aShip.
	cardHand throw: anAccelerationCard toAllShipsOn: zathura.
]

{ #category : #throwing }
CardThrower >> throws: aCancellationCard removing: aCard from: sourceShip [ 
	(cardHands cardHandOf: sourceShip)
		throw: aCancellationCard
		removingToAll: aCard
		on: zathura 
]

{ #category : #throwing }
CardThrower >> throws: aCard to: destinationShip from: sourceShip [ 
	| cardHand |
	cardHand := cardHands cardHandOf: sourceShip.
	cardHand throw: aCard to: destinationShip on: zathura .
]
