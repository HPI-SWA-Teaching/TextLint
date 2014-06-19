Glamour
hoverAction: anEvent
	"Opens BalloonMorph for current position and sets caret to former position"
	| oldPosition |
	Transcript show: anEvent; cr.
	oldPosition := editor caret.
	self handleInteraction: [editor mouseDown: anEvent].
	self tooltipWithRuleFailures.
	editor selectFrom:oldPosition to: (oldPosition - 1).
	