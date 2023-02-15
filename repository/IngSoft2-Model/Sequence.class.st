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
	collection:		<Object>


    Implementation Points
"
Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Sequence class >> newEmpty [
	^ self new initializeWith: {  }
]

{ #category : #'instance creation' }
Sequence class >> with: aCollection [

	^ self new initializeWith: aCollection
]

{ #category : #private }
Sequence >> add: anObject [ 
	collection  add: anObject .
]

{ #category : #actions }
Sequence >> detect: aFindingBlock [ 
	^collection detect: aFindingBlock .
]

{ #category : #actions }
Sequence >> do: anAction [ 
	collection do: anAction 
]

{ #category : #'find-select' }
Sequence >> first [
	^collection first .
]

{ #category : #initialization }
Sequence >> initializeWith: aCollection [

	collection := OrderedCollection new.
	aCollection do: [ :element | collection add: element ]
]

{ #category : #actions }
Sequence >> next [

	| aValue |
	aValue := collection  removeFirst.
	collection  addLast: aValue.
	^aValue 
]

{ #category : #actions }
Sequence >> sort: aSortingFunction [ 
	collection sort: aSortingFunction 
]
