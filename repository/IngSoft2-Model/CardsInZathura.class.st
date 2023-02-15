Class {
	#name : #CardsInZathura,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardsOnTable',
		'thrownCardsStack',
		'zathuraGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsInZathura class >> with: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	^ self new
		  initializeWith: aCollectionOfShips
		  and: aCollectionOfCards
		  from: aZathuraGame 
]

{ #category : #adding }
CardsInZathura >> addCardToTable: aCard [

cardsOnTable addCardToTable: aCard.

]

{ #category : #adding }
CardsInZathura >> addTheNextCardToHandCardOf: aShip [

	zathuraGame giveCardTo: aShip
]

{ #category : #actions }
CardsInZathura >> addToTheCardsStack: aCard [ 
	cardsOnTable addToTheCardsStack: aCard.
]

{ #category : #playing }
CardsInZathura >> findChangeOfRoll: aShip [

	^ cardsOnTable rollChangeOf: aShip
]

{ #category : #private }
CardsInZathura >> giveCard [

	^ deck next
]

{ #category : #initialization }
CardsInZathura >> initializeWith: aCollectionOfShips and: aCollectionOfCards from: aZathuraGame [

	deck := aCollectionOfCards asOrderedCollection asSequence.
	cardsOnTable := CardsOnTable initalizeNew.
	thrownCardsStack := OrderedCollection new.
	zathuraGame := aZathuraGame .
]

{ #category : #accessing }
CardsInZathura >> lastCardThrownOnTheGame [

^cardsOnTable lastCardThrownOnTheGame .
]

{ #category : #removing }
CardsInZathura >> removeFromCardsOnTable: aCard with: aCancellationCard [

	| theCard |
	theCard := cardsOnTable  findCardOnTable: aCard.
	cardsOnTable remove: theCard.
	cardsOnTable  addToTheCardsStack: aCancellationCard .
]
