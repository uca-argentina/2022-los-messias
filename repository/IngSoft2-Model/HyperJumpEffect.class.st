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
	parsecsSequence:		<Object>


    Implementation Points
"
Class {
	#name : #HyperJumpEffect,
	#superclass : #Effect,
	#instVars : [
		'parsecsSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertSequenceIsValid: parsecSequence [

	parsecSequence isEmpty ifTrue: [ 
		Error signal: 'Hyperjump cannot have a null parsec sequence' ].

	(parsecSequence anySatisfy: [ :parsec | parsec valueAsParsec <= 0 ]) ifTrue: [ 
		Error signal: 'Hyperjump cannot have less than zero parsecs in the sequence' ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecSequence [

	self assertSequenceIsValid: parsecSequence asOrderedCollection.
	^ self new initializeWith: parsecSequence asOrderedCollection 
]

{ #category : #action }
HyperJumpEffect >> applyFor: aShip on: aBoard [

	| parsecs |
	parsecs := parsecsSequence next.
	aBoard move: aShip byParsecs: (parsecs valueAsParsec)
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfNumbers [

	parsecsSequence := aCollectionOfNumbers
		                                asOrderedCollection asSequence.
	parsecsSequence sort: [ :positionA :positionB | 
		positionA valueAsParsec > positionB valueAsParsec ].

]
