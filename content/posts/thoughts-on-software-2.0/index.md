+++
title = 'Thoughts on "Software 2.0"'
date = 2023-11-02T11:13:00-05:00
featured_image = "robot.png"
+++

Six years ago, Andrej Karpathy wrote an article entitled [“Software 2.0”](https://karpathy.medium.com/software-2-0-a64152b37c35). In the article, Andrej refers to “Software 1.0” as human-engineered source-code that is compiled into a binary that does useful work. It’s basically, how software has been developed to date. In contrast, “Software 2.0”, is written in a much more abstract, human unfriendly language such as the weights of a neural network. It is left to the machine to determine the weights (which could be in the millions or billions for large language models) without human involvement in a process called training.

{{< figure src="robot.png" alt="Figure 1 — Getting the robots to write code so humans don’t have to" caption="Figure 1 — Getting the robots to write code so humans don’t have to" >}}

Andrej argues that this approach represents an emerging paradigm shift for building software.

I am inclined to agree. There has been significant progress in AI even since the six short years Andrej wrote his article. The image of the robot in Figure 1 was generated using AI (using Runway specifically) from a text prompt “show a robot sitting next to a person at a desk writing code on a computer terminal”.

However, new paradigms in my experience do not necessarily replace the old paradigms. There is a class of problem to which “Software 2.0” is undeniably better suited compared to the classic “Software 1.0” approach. These problems are “fuzzy” problems, where complete precision is not required. Examples of such fuzziness include:

- 84% accuracy rate in answering the question “Is it a cat?”
- 75% certain that the text is of positive sentiment
- 95% certain it will rain today at 3pm

In his [interview with Lex Fridman in 2019](https://www.youtube.com/watch?v=fjIhFzTUB9I), Bjarne Stroustrup reminds us that there are classes of problems that require and often demand precision and consistency. Bjarne argues that machine learning systems are not good enough for life threatening systems (self-driving cars are arguably life threatening systems).

As an example, a couple of months ago I created a simple NLP interface built on data from my own network (I was experimenting with the idea of building an AI powered network assistant). I asked the AI, “what devices were currently on my network”? The output is shown in Figure 1 below.

{{< figure src="netflowchat.png" alt="Figure 2 — Asking an AI a question “What devices are on my network”" caption="Figure 2 — Asking an AI a question “What devices are on my network?”" >}}

It responded with a decent list, however it did miss a couple of devices. Maybe this is good enough. Maybe not. If I had implemented this using a traditional, more precise, human engineered approach, it would have responded with a complete list. 

Bjarne’s viewpoint is interesting and one I’m not qualified to comment on. However, I would encourage software engineers to become skilled or at least familiar with the “Software 2.0” stack in addition to the classic “Software 1.0” stack because I do believe both approaches are valid. The trick is knowing which one to use for the problem at hand. Perhaps, the problem might also call for a hybrid approach.

One thing I am absolutely certain of is that these are exciting times to be a software engineer.
