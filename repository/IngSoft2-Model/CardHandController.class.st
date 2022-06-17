Class {
	#name : #CardHandController,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardHands',
		'cardsOnTable',
		'thrownCardsStack',
		'zathuraGame'
	],
	#classInstVars : [
		'cardHands',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardHandController class >> with: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	^ self new
		  initializeWith: aCollectionOfShips
		  and: aCollectionOfCards
		  from: aZathuraGame 
]

{ #category : #private }
CardHandController >> addCardToTable: aCard [

	cardsOnTable add: aCard.
]

{ #category : #actions }
CardHandController >> addToHandCardOf: aShip card: aCard [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand add: aCard
]

{ #category : #moving }
CardHandController >> applyLastEffectOn: aShip [

	zathuraGame applyLastEffectOn: aShip
]

{ #category : #accessing }
CardHandController >> assertCardHasBeenThrown [

	thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
]

{ #category : #asserting }
CardHandController >> assertIsOnTable: aCard [

	aCard ifEmpty: [ Error signal: 'This card is not active in the table' ]
]

{ #category : #accessing }
CardHandController >> cardHandOf: aShip [

	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #playing }
CardHandController >> cardsAffecting: aShip [

	^ cardsOnTable select: [ :aCard | aCard ship includes: aShip ]
]

{ #category : #accessing }
CardHandController >> cardsOf: aShip [

	| cards |
	cards := self cardHandOf: aShip.
	^ cards handOfCards
]

{ #category : #asserting }
CardHandController >> findCardOnTable: aCard [

	| theCard |
	theCard := (cardsOnTable select: [ :card | card = aCard ]).
	self assertIsOnTable: theCard.
	^ theCard first
]

{ #category : #playing }
CardHandController >> findChangeOfRoll: aShip [

	^ (self cardsAffecting: aShip) sum: [ :aCard | aCard changeOfRoll ]
]

{ #category : #private }
CardHandController >> giveCard [

	^ deck next
]

{ #category : #initialization }
CardHandController >> initializeCardHandsBy: aCollectionOfShips [

	cardHands := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		cardHands add: (CardHand of: aShip with: { 
					 self giveCard .
					 self giveCard }) ].
	^ cardHands
]

{ #category : #initialization }
CardHandController >> initializeWith: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	deck := aCollectionOfCards asOrderedCollection asSequence.
	cardHands := self initializeCardHandsBy: aCollectionOfShips.
	zathuraGame := aZathuraGame.
	cardsOnTable := OrderedCollection new.
	thrownCardsStack := OrderedCollection new
]

{ #category : #testing }
CardHandController >> isTurnOf: aShip [

	^ (zathuraGame isTurnOf: aShip)
]

{ #category : #accessing }
CardHandController >> lastCardThrownOnTheGame [

	self assertCardHasBeenThrown.
	^ thrownCardsStack last
]

{ #category : #set }
CardHandController >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := self findCardOnTable: aCard.
	cardsOnTable remove: theCard.
]

{ #category : #accessing }
CardHandController >> ships [

	^(zathuraGame ships)
]

{ #category : #private }
CardHandController >> throw: aCard [

	thrownCardsStack add: aCard
]

{ #category : #actions }
CardHandController >> throws: aCancellationCard removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: aCancellationCard
		removingToAll: aCard
		in: self
]

{ #category : #actions }
CardHandController >> throws: aCard to: destinationShip from: sourceShip [

	| cardHand |
	cardHand := self cardHandOf: sourceShip.
	cardHand throw: aCard to: destinationShip in: self
]

{ #category : #actions }
CardHandController >> throws: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: cancellationCard
		to: destinationShip
		removing: aCard
		in: self
]

{ #category : #actions }
CardHandController >> throws: aCard toAllShipsFrom: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand throw: aCard toAllShipsin: self
]
