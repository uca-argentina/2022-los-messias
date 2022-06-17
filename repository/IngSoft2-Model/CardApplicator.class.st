Class {
	#name : #CardApplicator,
	#superclass : #Object,
	#instVars : [
		'game',
		'cardHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardApplicator class >> intializeIn: aZathuraGame [ 
	^self new initializeWith: aZathuraGame .
]

{ #category : #actions }
CardApplicator >> addTo: aShip ToHandCard: aCard [ 
	 | cards |
cards:= cardHands select: [ :aCardHand | aCardHand ship = aShip ].
^(cards first) add: aCard .
	
]

{ #category : #accesing }
CardApplicator >> cardHandOf: aShip [

	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #accesing }
CardApplicator >> cardsOf: aShip [ 
	| cards |
	cards:= cardHands select: [ :cardHand | cardHand ship = aShip ].
	^(cards next) handOfCards
]

{ #category : #initalization }
CardApplicator >> initializeWith: aZathuraGame [

	game := aZathuraGame.
	cardHands:= Sequence new.
	game ships do:[:aShip | cardHands add: (CardHand of: aShip with: {(game giveCard).  (game giveCard)})]
]

{ #category : #action }
CardApplicator >> throws: aCancellationCard removing: aCard from: sourceShip [ 
	(self cardHandOf: sourceShip)
		throw: aCancellationCard
		removingToAll: aCard
		in: game
]

{ #category : #actions }
CardApplicator >> throws: aCard to: destinationShip from: sourceShip [

	| cardHand |
	cardHand := self cardHandOf: sourceShip. 
	cardHand throw: aCard to: destinationShip in: game
]

{ #category : #action }
CardApplicator >> throws: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: cancellationCard
		to: destinationShip
		removing: aCard
		in: game
]

{ #category : #actions }
CardApplicator >> throws: aCard toAllShipsFrom: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand throw: aCard toAllShipsin: game
]
