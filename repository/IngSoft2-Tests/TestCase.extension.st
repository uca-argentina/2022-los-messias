Extension { #name : #TestCase }

{ #category : #'*IngSoft2-Tests' }
TestCase >> should: creationOfAnObject raise: error withMessage: errorMessage [

self should: creationOfAnObject raise: error whoseDescriptionIncludes: errorMessage description: 'Test did not failed as expected'.
]
