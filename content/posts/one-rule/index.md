+++
title = 'One Rule to Rule Them All (Software Engineering)'
date = 2023-11-28T12:36:52-04:00
featured_image = "one-rule.png"
+++

{{< figure src="one-rule.png" alt="rule book"  >}}

[Dave Thomas](https://pragdave.me/) suggested [One Rule to Rule Them All](https://www.youtube.com/watch?v=QvK3Pxmwcyc&t=534s), during a talk in 2022. Spoiler Alert, the one rule is “Make It Easier to Change”.

Please go watch the [video](https://www.youtube.com/watch?v=QvK3Pxmwcyc&t=534s), but in essence, a lot of what we do to craft software is to make it easier to change later.

The word “soft” is something that is easy to mold, fold, cut, compress. In contrast to hardware which, once it is manufactured is not easy to mold, fold, cut, compress.

Why [design patterns?](https://en.wikipedia.org/wiki/Software_design_pattern) Why [SOLID?](https://en.wikipedia.org/wiki/SOLID) Why [SRP?](https://en.wikipedia.org/wiki/Single-responsibility_principle) Why [modularity?](https://www.modularmanagement.com/blog/software-modularity) Why [Microservices?](https://en.wikipedia.org/wiki/Microservices) Why [CI/CD pipelines?](https://en.wikipedia.org/wiki/CI/CD) Why [Decoupling?](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) The answer to all of these questions according to Dave is to “Make It Easier to Change”.

He is not wrong. I would propose a slight tweak to the one rule as suggested by Dave. Instead of “Make It Easier to Change”, I would propose:

**“Make It Easier to Change with confidence”.**

It’s a subtle change (no pun intended). What does the “with confidence mean” exactly? — Read on.

Up until as late as 2014, Facebook famously had the [motto](https://en.wikipedia.org/wiki/Meta_Platforms#History) “Move fast and break things”. It turns out, moving fast is good, breaking things not so good. To their credit, they did tweak their motto (according to Wikipedia) to something more responsible.

Automated tests and [TDD](https://en.wikipedia.org/wiki/Test-driven_development) are a good example of supporting the “with confidence” suffix. You could [argue that a dogmatic approach to tests and TDD](https://www.youtube.com/watch?v=EZ05e7EMOLM&t=3319s) can actually make it more difficult to change — but, at least a pragmatic approach to TDD is required for the confidence piece of the equation.

Another good example is security. Security controls do not make it easier to change, just like having to take your shoes off does not make it easier to fly. However, security controls and practices certainly fit into the “with confidence” suffix.

So, what is the take-away from this? — especially if you are early in career. I think the way to approach it is, start with understanding why we need to make it (software) easier to change (with confidence), then begin exploring how exactly we achieve that outcome. There are lots of approaches, methodologies, techniques, principles to branch off into. For the how, pick your own adventure whether that be studying design patterns, or the SOLID principles — but just connect it back to this one rule to rule them all.
