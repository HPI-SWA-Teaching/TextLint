Glamour
tooltipWithRuleFailures
	| balloon ruleFailures |
	ruleFailures := self ruleFailuresAtCaret.
	ruleFailures isEmpty ifTrue: [ ^self ].
	balloon := TLTooltip new.
	ruleFailures do: [ :each |
		balloon contents: balloon contents, each rule name.
		ruleFailures last = each ifFalse: [balloon contents: balloon contents, '; '.]. 
	].	
	balloon openInWorld.
