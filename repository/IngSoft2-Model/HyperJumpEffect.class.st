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

	(parsecSequence anySatisfy: [ :parsec | parsec <= 0 ]) ifTrue: [ 
		Error signal: 'Hyperjump cannot have less than zero parsecs in the sequence' ]
]

{ #category : #conversion }
HyperJumpEffect class >> convertToParsec: aCollectionOfLightYears [ 
	| parsecs |
	parsecs:= OrderedCollection new.
	aCollectionOfLightYears do: [ :aLightYear | parsecs add: ((aLightYear / 3) asInteger)].
	^parsecs
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecSequence [

	self assertSequenceIsValid: parsecSequence.
	^ self new initializeWith: parsecSequence
]

{ #category : #'instance creation' }
HyperJumpEffect class >> withLightYears: lightYearsSequence [

	| parsecSequence |
	parsecSequence:= self convertToParsec: lightYearsSequence.
	self assertSequenceIsValid: parsecSequence.
	^ self new initializeWith: parsecSequence
]

{ #category : #'instance creation' }
HyperJumpEffect >> applyFor: aShip on: aBoard [

	| parsecs |
	parsecs := parsecsSequence next.
	aBoard move: aShip byParsecs: parsecs.
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfNumbers [

	| anOrderedCollectionOfNumbers |
	anOrderedCollectionOfNumbers := aCollectionOfNumbers asOrderedCollection.
	anOrderedCollectionOfNumbers sort: [ 
		                              :positionA 
		                              :positionB | positionA > positionB ].
	
	parsecsSequence := Sequence withAll: anOrderedCollectionOfNumbers
]
