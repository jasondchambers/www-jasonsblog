+++
title = 'Static vs Dynamic Typing — which one is the best?'
date = 2023-11-02T11:14:00-05:00
featured_image = "somecode.png"
+++

In September 2023, Turbo 8 [announced](https://world.hey.com/dhh/turbo-8-is-dropping-typescript-70165c01) they were dropping TypeScript. This (re-)ignited the age-old debate of static vs dynamic typing and the question of which one is superior. Here’s my perspective on this enduring discussion.

Which one is superior? The answer: both.

{{< figure src="somecode.png" alt="Figure 1 Just some random Python code I wrote in 2023" caption="Figure 1 — Just some random Python code I wrote in 2023" >}}

While this may seem like a non-committal stance, I assure you it’s not. Both approaches have their merits and, like most decisions in engineering, it boils down to making trade-offs. Personally, I have a slight preference for static typing as it aids in identifying defects in the code at an early stage. This proactive approach to error detection is undeniably beneficial. However, there are times when I need to quickly prototype a solution to explore a problem, and in such scenarios, I don’t want the type system to hinder my progress.

For instance, I recently enabled strict typing checks for a [project](https://github.com/jasondchambers/agileplanner) I’m working on. During this process, I discovered a hidden defect. Had I not enabled strict typing, this defect could have remained undetected for weeks or even months.

Critics might argue that static typing makes the code less readable and more verbose, while others might contend that it enhances readability. Both viewpoints are valid.

I appreciate how [Python accommodates both dynamic and static typing](https://peps.python.org/pep-0483/), allowing developers to choose the most suitable approach based on their specific use case.

With these thoughts in mind, isn’t it time we moved past this debate and focused our energies on more pressing matters?
