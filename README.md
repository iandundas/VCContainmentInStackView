# View Controller containment in a StackView
Showing how ViewControllers can be presented as components within in a UIStackView, linked together using ReactiveKit

An example of an architecture built upon a UIStackView (as an alternative to using UITableView):
- items are positioned on top of each other
- VCs can be contained in an `ContainerStackItem` item
- the `ContainerStackItem` gives us control over the presentation of that VC within the stack
- this demo shows how they can be bound together to affect one another, using [ReactiveKit](https://github.com/ReactiveKit/ReactiveKit).

This basic example has two sliders, one which controls the height of the bottom item (which shows a scrollView full of rectanges), the other which controls the number of coloured rectangles present in the scrollView. When the number of boxes overflows the set height, the containing view becomes scrollable.

It also shows ("On it's own" in the screenshot) how these components can also equally be presented as full-screen regular view controllers as well.

<img src="http://f.cl.ly/items/3Q3C2L1Z441v2X053U2k/Image%202016-02-11%20at%2012.32.14%20am.png" />
