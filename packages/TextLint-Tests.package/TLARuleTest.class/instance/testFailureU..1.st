test
testFailureU

	| aRule aWord aDocument anotherWord aSentence words sentences aParagraph paragraphs results word1 word2 |
	
	words := OrderedCollection new.
	word1 := words add: (TLWord with: (PPToken on: 'A')).
	words add: (TLWhitespace with: (PPToken on: ' ')).
	word2 := words add: (TLWord with: (PPToken on: 'UT')).
	words add: (TLWord with: (PPToken on: 'that')).
	words add: (TLWord with: (PPToken on: 'test')).
	aSentence := TLSentence withAll: words.
	sentences := OrderedCollection with: aSentence.
	aParagraph := TLParagraph withAll: sentences.
	paragraphs := OrderedCollection with: aParagraph.
	aDocument := TLDocument withAll: paragraphs.
	
	aRule := TLARule new.
	
	results := aRule runOn: aDocument.
	
	self assert: results size = 1.
	self assert: results first isRuleFailure.
	self assert: results first element isPhrase.
	self assert: results first element words first = word1.
	self assert: results first element words last = word2.
	self assert: results first rule = aRule.

	