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

{ #category : #adding }
CardManager >> addCardToTable: aCard [

	cardsOnTable add: aCard.
]

{ #category : #adding }
CardManager >> addTheNextCardToHandCardOf: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand add: (self giveCard )
]

{ #category : #adding }
CardManager >> addToTheCardsStack: aCard [

	thrownCardsStack add: aCard
]

{ #category : #resendingToZathura }
CardManager >> applyLastEffectOn: aShip [

	zathuraGame applyLastEffectOn: aShip
]

{ #category : #asserting }
CardManager >> assertCardHasBeenThrown [

	thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
]

{ #category : #asserting }
CardManager >> assertIsOnTable: aCard [

	aCard ifEmpty: [ Error signal: 'This card is not active in the table' ]
]

{ #category : #private }
CardManager >> cardHandOf: aShip [

	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #private }
CardManager >> cardsAffecting: aShip [

	^ cardsOnTable select: [ :aCard | aCard ship includes: aShip ]
]

{ #category : #accessing }
CardManager >> findCardOnTable: aCard [

	| theCard |
	theCard := cardsOnTable select: [ :card | card = aCard ].
	self assertIsOnTable: theCard.
	^ theCard first
]

{ #category : #playing }
CardManager >> findChangeOfRoll: aShip [

	^ (self cardsAffecting: aShip) sum: [ :aCard | aCard changeOfRoll ]
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

{ #category : #resendingToZathura }
CardManager >> isTurnOf: aShip [

	^ (zathuraGame isTurnOf: aShip)
]

{ #category : #accessing }
CardManager >> lastCardThrownOnTheGame [

	self assertCardHasBeenThrown.
	^ thrownCardsStack last
]

{ #category : #removing }
CardManager >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := self findCardOnTable: aCard.
	cardsOnTable remove: theCard.
]

{ #category : #accessing }
CardManager >> ships [

	^ cardHands collect: [ :cardHand | cardHand ship ]
]

{ #category : #throwing }
CardManager >> throws: aCancellationCard removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: aCancellationCard
		removingToAll: aCard
		on: self
]

{ #category : #throwing }
CardManager >> throws: aCard to: destinationShip from: sourceShip [

	| cardHand |
	cardHand := self cardHandOf: sourceShip.
	cardHand throw: aCard to: destinationShip on: self
]

{ #category : #throwing }
CardManager >> throws: cancellationCard to: destinationShip removing: aCard from: sourceShip [

	(self cardHandOf: sourceShip)
		throw: cancellationCard
		to: destinationShip
		removing: aCard
		on: self
]

{ #category : #throwing }
CardManager >> throws: aCard toAllShipsFrom: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand throw: aCard toAllShipsOn: self
]
