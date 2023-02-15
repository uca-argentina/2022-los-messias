"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	numbers:		<Object>


    Implementation Points
"
Class {
	#name : #SequencialLoadedDie,
	#superclass : #Object,
	#instVars : [
		'dies'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SequencialLoadedDie class >> assertValid: anArrayOfNumbers [

		(anArrayOfNumbers size > 1) ifFalse: [ 
		Error signal: 'Sequential die should be loaded with more than one number']
]

{ #category : #'instance creation' }
SequencialLoadedDie class >> with: anArrayOfNumbers [

	self assertValid: anArrayOfNumbers.
	^ self new initializeWith: anArrayOfNumbers
]

{ #category : #initialization }
SequencialLoadedDie >> initializeWith: aCollectionOfNumbers [

	dies := Sequence with: (self loadSequenceOfDiesWith: aCollectionOfNumbers)
]

{ #category : #initialization }
SequencialLoadedDie >> loadSequence: aCollectionOfNumbers [

	| collectionOfDies |
	collectionOfDies := OrderedCollection new.
	aCollectionOfNumbers do: [ :number | 
		collectionOfDies add: (LoadedDie with: number) ].
	^ collectionOfDies
]

{ #category : #initialization }
SequencialLoadedDie >> loadSequenceOfDiesWith: aCollectionOfNumbers [

	| collectionOfDies |
	collectionOfDies := OrderedCollection new.
	aCollectionOfNumbers do: [ :number | 
		collectionOfDies add: (LoadedDie with: number) ].
	^ collectionOfDies
]

{ #category : #rolling }
SequencialLoadedDie >> roll [

	| result |
	result := (dies next) roll.
	^ result
]
