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

	cardsOnTable add: aCard
]

{ #category : #adding }
CardManager >> addTheNextCardToHandCardOf: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand add: (self giveCard )
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
CardManager >> assertIsYourTurn: aShip [

	(self isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #private }
CardManager >> cardHandOf: aShip [

	^ cardHands detect: [ :aCardHand | aCardHand ship = aShip ]
]

{ #category : #private }
CardManager >> cardsAffecting: aShip [

	^ cardsOnTable select: [ :aCard | aCard ship includes: aShip ]
]

{ #category : #accessing }
CardManager >> findCardOnTable: aCard [

	^ cardsOnTable detect: [ :card | card = aCard ] ifNone:[ Error signal: 'This card is not active in the table' ].
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

	^ aCollectionOfShips collect: [ :aShip | 
		  CardHand of: aShip with: { 
				  self giveCard.
				  self giveCard } ]
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
CardManager >> throws: aCard to: destinationShip [

	| cardHand effectOfCard sourceShip |
	sourceShip := aCard sourceShip.
	cardHand := self cardHandOf: sourceShip.
	cardHand remove: aCard.

	effectOfCard := aCard effectOn: self.
	effectOfCard value: destinationShip.
	thrownCardsStack add: aCard
]
