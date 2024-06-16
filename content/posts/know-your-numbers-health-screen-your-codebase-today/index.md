+++
title = 'Know Your Numbers - Health Screen Your Codebase Today'
date = 2023-11-02T11:12:00-05:00
featured_image = "bloodpressure.png"
tags = ['Software Engineering']
+++

The American Heart Association refers to high blood pressure as a silent killer. Many people don’t even know they have it. Often the signs and symptoms are misunderstood. High blood pressure develops slowly over time. Undiagnosed, the consequences can be severe. Like most things, prevention is often better than the cure.

{{< figure src="bloodpressure.png" alt="Blood pressure monitoring" >}}

This brings to mind the concept of deteriorating health in a codebase, commonly known as software entropy. Entropy, a term borrowed from physics, denotes the level of disorder within a system. In certain applications, such as cryptography, entropy is highly valued when generating random numbers. This disorder hinders an adversary’s ability to discern patterns. However, when it comes to software, a chaotic system is far from ideal. The term ‘software entropy’ is frequently used synonymously with ‘technical debt’.

I like this definition of Technical Debt, excerpted from [“Managing Technical Debt in Software Engineering”](https://drops.dagstuhl.de/opus/volltexte/2016/6693/pdf/dagrep_v006_i004_p110_s16162.pdf):

_“In software-intensive systems, technical debt is a collection of design or implementation constructs that are expedient in the short term, but set up a technical context that can make future changes more costly or impossible. Technical debt presents an actual or contingent liability whose impact is limited to internal system qualities, primarily maintainability and evolvability.”_

For the remainder of this article, I will use the generic term “code health” to represent the state of software entropy or technical debt for a particular codebase.

Similar to high blood pressure, poor code health isn’t immediately apparent from an external perspective. Simply put, you cannot see the source code of the products and apps that you are using. Yet, akin to the severe consequences of untreated hypertension, the repercussions of neglected code health can be significant.

In my observation, code health tends to decline gradually as the codebase expands and the team evolves. Original developers may move on. Their successors will have an incomplete understanding of the codebase. The situation can be exacerbated by feature creep and product pivots. The surrounding environment also plays a significant role. Teams often face immense pressure to deliver new features and functionality in order to stay competitive and meet market and customer demands. This leaves scant room for improving deteriorating code health. Essentially, the management of code health can suffer in the face of the relentless drive to deliver new features and functionality.

The main consequence of an unhealthy codebase is that it erodes the team’s ability to be responsive and competitive. Without looking at the code, here are some indicators to pay attention to that may be attributed to declining code health:

- Unintentional side-effects observed — one thing is changed that causes something else to break
- Poor developer experience — developers prefer to work on healthy codebases
- It becomes easy to unintentionally introduce new defects and difficult to fix defects
- Development and maintenance costs increase
- Team productivity decreases

Now, let’s dig a little deeper and observe what unhealthy code looks like. The main indicator of poor code is excessive code complexity. Figure 1 shows an example analysis using an early version of [CodeScene](https://codescene.com/) against a legacy codebase:

{{< figure src="codescene-1.png" alt="Alex Honnold free solo climbing on El Capitan’s Freerider in Yosemite National Park. (National Geographic/Jimmy Chin" caption="Figure 1 — CodeScene analysis of a sample of code in poor health" >}}

Now that we have a better understanding of what code health is, the consequences of poor code health and what it looks like, here are are some of my own recommendations for managing code health:

1. Prevention is always than the cure — start measuring your code health now
2. Pick a tool. It doesn’t matter which tool you use — find one that works for you. I personally like CodeScene because it provides other insights into the team and the codebase. Others may prefer SonarCloud, Qodana or Codacy
3. Measure code health as part of your CI/CD pipeline — consider blocking PR merges if the changes contribute to declining health
4. Pay attention to trends
5. Prioritize areas that are in declining health AND that have the highest rate of change — you most likely will not have budget to fix all the issues at once.
6. Use data to articulate the risk and the need to re-invest in the health of the codebase to inform and gain support from the stake-holders
7. Celebrate your successes as you begin to slowly recover the health of the codebase
