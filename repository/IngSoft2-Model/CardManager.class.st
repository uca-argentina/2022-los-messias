Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'shipsHand'
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
cards:= shipsHand select: [ :aCardHand | aCardHand ship = aShip ].
^(cards first) add: aCard .
	
]

{ #category : #actions }
CardManager >> cancel: aCard from: aShip [ 
	(game getCardHandOf: aShip) using: CancellationCard new removingToAll: aCard in: game.
]

{ #category : #accesing }
CardManager >> cardsOf: aShip [ 
	| cards |
	cards:= shipsHand select: [ :cardHand | cardHand ship = aShip ].
	^(cards next) handOfCards
]

{ #category : #initalization }
CardManager >> initializeWith: aZathuraGame [

	game := aZathuraGame.
	shipsHand:= Sequence new.
	game ships do:[:aShip | shipsHand add: (CardHand of: aShip with: {(game getCard).  (game getCard)})]
]

{ #category : #actions }
CardManager >> ship: aShip throws: aCard to: anotherShip [ 
	| cards cardHand |
	cards:= shipsHand select: [ :aCardHand | aCardHand ship = aShip  ].
	(cards first) using: aCard to: anotherShip in: game . 
]

{ #category : #actions }
CardManager >> throws: aCard from: aShip [ 
	(game getCardHandOf: aShip) using: aCard toAllShipsin: game
]
