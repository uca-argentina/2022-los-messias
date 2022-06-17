Class {
	#name : #CardManager,
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
CardManager class >> with: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	^ self new
		  initializeWith: aCollectionOfShips
		  and: aCollectionOfCards
		  from: aZathuraGame 
]

{ #category : #private }
CardManager >> addCardToTable: aCard [

	cardsOnTable add: aCard.
]

{ #category : #actions }
CardManager >> addTo: aShip ToHandCard: aCard [

	|  cardHand |
	cardHand := self cardHandOf: aShip.
	^ cardHand add: aCard
]

{ #category : #moving }
CardManager >> applyLastEffectOn: aShip [

	zathuraGame applyLastEffectOn: aShip
]

{ #category : #accessing }
CardManager >> assertCardHasBeenThrown [

	thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
]

{ #category : #asserting }
CardManager >> assertIsOnTable: aCard [

	aCard ifEmpty: [ Error signal: 'This card is not active in the table' ]
]

{ #category : #accesing }
CardManager >> cardHandOf: aShip [

	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #accesing }
CardManager >> cardsOf: aShip [

	| cards |
	cards := self cardHandOf: aShip.
	^ cards handOfCards
]

{ #category : #accessing }
CardManager >> cardsOnTableOf: aCard [

	^ (cardsOnTable select: [ :card | card hasEqualClass: aCard ]) size
]

{ #category : #asserting }
CardManager >> findCardOnTable: aCard [

	| theCard |
	theCard := (cardsOnTable select: [ :card | card = aCard ]).
	self assertIsOnTable: theCard.
	^ theCard first
]

{ #category : #playing }
CardManager >> findChangeOfRoll: aShip [

	| cardsThatApplyEffectOnShip changeOfRoll |
	cardsThatApplyEffectOnShip := cardsOnTable select: [ :aCard | 
		                              aCard ship includes: aShip ].
	changeOfRoll := cardsThatApplyEffectOnShip sum: [ :aCard | 
		                aCard changeOfRoll ].
	^ changeOfRoll
]

{ #category : #private }
CardManager >> giveCard [

	^ deck next
]

{ #category : #initialization }
CardManager >> initializeCardHandsBy: aCollectionOfShips [

	cardHands := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		cardHands add: (CardHand of: aShip with: { 
					 self giveCard .
					 self giveCard }) ].
	^ cardHands
]

{ #category : #initialization }
CardManager >> initializeWith: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	deck := aCollectionOfCards asOrderedCollection asSequence.
	cardHands := self initializeCardHandsBy: aCollectionOfShips.
	zathuraGame := aZathuraGame.
	cardsOnTable := OrderedCollection new.
	thrownCardsStack := OrderedCollection new
]

{ #category : #testing }
CardManager >> isTurnOf: aShip [

	^ (zathuraGame isTurnOf: aShip)
]

{ #category : #accessing }
CardManager >> lastCardThrownOnTheGame [

	self assertCardHasBeenThrown.
	^ thrownCardsStack last
]

{ #category : #set }
CardManager >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := self findCardOnTable: aCard.
	cardsOnTable remove: theCard.
]

{ #category : #accessing }
CardManager >> ships [

	^(zathuraGame ships)
]

{ #category : #private }
CardManager >> throw: aCard [

	thrownCardsStack add: aCard
]

{ #category : #action }
CardManager >> throws: aCancellationCard removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: aCancellationCard
		removingToAll: aCard
		in: self
]

{ #category : #actions }
CardManager >> throws: aCard to: destinationShip from: sourceShip [

	| cardHand |
	cardHand := self cardHandOf: sourceShip.
	cardHand throw: aCard to: destinationShip in: self
]

{ #category : #action }
CardManager >> throws: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: cancellationCard
		to: destinationShip
		removing: aCard
		in: self
]

{ #category : #actions }
CardManager >> throws: aCard toAllShipsFrom: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand throw: aCard toAllShipsin: self
]
