Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'cardHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardManager class >> intializeIn: aZathuraGame [ 
	^self new initializeWith: aZathuraGame .
]

{ #category : #actions }
CardManager >> addTo: aShip ToHandCard: aCard [ 
	 | cards |
cards:= cardHands select: [ :aCardHand | aCardHand ship = aShip ].
^(cards first) add: aCard .
	
]

{ #category : #'as yet unclassified' }
CardManager >> cardHandOf: aShip [

	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #accesing }
CardManager >> cardsOf: aShip [ 
	| cards |
	cards:= cardHands select: [ :cardHand | cardHand ship = aShip ].
	^(cards next) handOfCards
]

{ #category : #initalization }
CardManager >> initializeWith: aZathuraGame [

	game := aZathuraGame.
	cardHands:= Sequence new.
	game ships do:[:aShip | cardHands add: (CardHand of: aShip with: {(game giveCard).  (game giveCard)})]
]

{ #category : #action }
CardManager >> throw: aCancellationCard removing: aCard from: sourceShip [ 
	(self cardHandOf: sourceShip)
		throwInstant: aCancellationCard
		removingToAll: aCard
		in: game
]

{ #category : #action }
CardManager >> throw: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throwInstant: cancellationCard
		to: destinationShip
		removing: aCard
		in: game
]

{ #category : #actions }
CardManager >> throws: aCard to: destinationShip from: sourceShip [

	| cardHand |
	cardHand := self cardHandOf: sourceShip.
	cardHand throwPermanent: aCard to: destinationShip in: game
]

{ #category : #actions }
CardManager >> throws: aCard toAllShipsFrom: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand throwPermanent: aCard toAllShipsin: game
]

{ #category : #action }
CardManager >> throwsInstant: aCard to: aShip from: aSourceShip [ 

	| cardHand |
	cardHand := self cardHandOf: aSourceShip.
	cardHand throwInstant: aCard to: aShip in: game
]
