+++
title = 'Notes about Software Architecture - Part 1'
date = 2024-05-17T10:00:00-04:00
featured_image = "funny_architecture.jpg"
+++

In this series, I'd like to share my experiences of over 20+ years of architecting large complex enterprise systems, products and services. If you are involved in any kind of software development endeavor in whatever role, hopefully you find something of value in this series. The first question you may immediately ask is, if some of these guidelines are borne from experiences from years ago, surely they are out of date? Well, it's true that technology changes and the rate of change appears to be accelerating. My design for a new system, service or application today would certainly look different to a design I may have conceived of three years ago in terms of technology choices. However, what I have learned is that there are enduring architectural and software quality principles to consider that transcend trends in technology.

Firstly, it may make sense to define what software architecture is. A software architecture describes the fundamental structures of a software system and the interactions between these structures. It defines the essential elements of a system's internal organization. Similar to traditional building architecture, it implies some kind of plan or blueprint for the development teams to follow. However, inevitably over time what usually happens is the actual architecture you end up with will likely differ from what you may have intended. As you zoom in, the software architecture is also about the technology choices you make and the patterns you plan to use.

I personally don't like the term "architecture", but it is widely accepted and can be argued to be similar enough to traditional (building) architecture. Software architecture is an ongoing concern when compared to traditional (building) architecture, and so is something that needs to be maintained.

If you are interested in diving more into the definition, I recommend [Martin Fowler's essay](https://www.martinfowler.com/architecture/)

## Why Architect?

This is a very good question. Why even bother? When we are developing some system, application or service it's worth reminding the [one rule to rule them all](https://circleinaspiral.com/posts/one-rule/):

_Make It Easier to Change with confidence_

If you ignore the software architecture at any stage of the lifecycle inevitably a build-up of cruft starts to creep in. As described by [Martin Fowler](https://www.martinfowler.com/architecture/), poor architecture is a major contributor to the growth of cruft. The cruft gets in the way making modifications much harder. Here are some indicators that maybe the architecture is in a poor state:

1. Quality issues with the product/service
2. Declining customer retention rates
3. Declining customer satisfaction scores
4. Lengthy cycle times to deliver new capabilities
5. High maintenance costs
6. Availability challenges (failing to meet SLAs and SLOs)
7. Slow response to address vulnerabilities
8. Low morale (poor developer experience)
9. Performance issues
10. Lengthy onboarding of new engineers

You may argue that your system is "finished" or will be soon at which point you may declare that you don't really care about making it easier to change. The idea of [finished software](https://world.hey.com/dhh/finished-software-8ee43637) in my experience is a myth. It is true that the system may be considered functionally complete. However even if there are no new features planned anytime soon, there will **always** be a need to maintain it if only to deal with vulnerabilities (most likely in your software supply chain).

Maybe then if we look after the architecture, we can improve our chances of avoiding these poor outcomes. But how exactly might we look after the architecture? What do we need to consider? In my experience, there are four major areas to consider:

1. Technology
2. Business needs/The customer
3. Organizational Structure (of the engineering teams)
4. The People in the (engineering) organization

Let's expand a little on each of these considerations.

The main takeaway is that it’s not (just) about technology. That is certainly an important consideration. You must however first consider the business needs and work your way back to technology. You must understand deeply the problems the business is needing to solve. This is to make sure you are spending resources solving the right problems.

An often overlooked consideration is the structure of the organization. This is an important consideration because the way an organization is structured can directly influence the design of its systems \[ <sup>1</sup> ]. In addition, the communication channels and relationships within an organization will be reflected in the architecture of the systems they develop.

The fourth and final component for consideration is the people who do the actual work of delivering the software. You need to consider their perspective and earn their trust. They will have valuable input into any architectural decisions you make. They will need to feel included and part of the decision making process if you are to be successful in influencing them to follow the vision.

## Guidelines For Avoiding A Crufty Architecture

Firstly, these are guidelines shaped by my experiences. They may or may not be applicable for your particular situation so don't follow blindly. 

These guidelines are not exhaustive. I plan to continue to add to them in future articles in this series.

### Plan For Architecture Evolution

We cannot predict the future. Nobody can, so why even attempt to make hard architectural decisions that you and the team will have to live with for many years? Instead, design and build for what you need and what you know right now. Evaluate the architecture by asking the question - "Is it still easy to change with confidence"? Over the course of two years, while at Urjanet we evolved the architecture three times (version 1 was named "Ozone", version 2 "Smog", version 3 named "Rainforest"). Each iteration replaced the previous iteration. As this was a startup, the scale of each iteration met the scale needs of the growing business at the time.

I have found this incremental approach to architecture to be valuable because it helps to avoid over and under-engineering.

### Favor Smaller Units of Deployment

Smaller units are lighter, easier to understand and as long as they are independent they support a higher rate of change with confidence. During my tenure with Lancope/Cisco as an Engineering Leader of the [Strealthwatch/Secure Network Analytics product](https://www.cisco.com/site/us/en/products/security/security-analytics/secure-network-analytics/index.html), we had major releases every six months. It was a large and complex product. We did attempt to accelerate the release cycle to every three months, but we had to backtrack because of increased maintenance costs as we increased the number of released versions we needed to support in the field. In addition, the upgrade process was fairly involved and as such our customers were not able to upgrade at the same pace as our release cadence. The slow release cycle was frustrating to everybody. We knew the core product architecture needed some attention, but the market does not wait and so we needed a quick way to get value out to the market sooner.

A creative work-around to these challenges, the concept of Apps were introduced. Apps are similar in concept to the apps you install on a smartphone; they are optional, independently releasable features that enhance and extend the capabilities of the core product. The release schedule for Apps is independent from the core product, and so they could be updated as needed and those updates are not tied to the schedule of a core release. The ability to gather timely customer feedback, iterate quickly, start with a clean-sheet and develop on a stable platform without the need for coordination across multiple teams enabled the various teams who worked on Apps to deliver some incredible results. The developer experience vastly improved.

This is not a new idea. The design of UNIX provides a wonderful example of the enduring quality of modularity.

It's not just diminutive units of deployment that can provide benefits. In my experience I have found many things where small is usually better. Small Teams are better than Large Teams. Small functions are better than large unwieldy functions. Small Bounded Contexts are better than Large Domain Models.

### Understand The Relationship Between the Architecture and the Organization Structure

Earlier in my career during my delta.com days, we were struggling to increase our pace of delivery as the number of features on the website increased along with the size of the teams. We had outgrown the architecture. I have observed this situation several times over the course of my career. As the organization grows, the architecture can often get left behind. On closer inspection, in those early days the architecture of the code base was organized into horizontal layers (UI, Business, Data) as shown in figure 1.

{{< figure src="delta-dot-com.png" title="Figure 1: Evolving the delta.com application to align with the organization structure (circa 2000)" >}}

The problem was that how we organized into teams did not match horizontal layers in the architecture. The Application Teams were organized into three areas: 1. Preflight (Online Check-in, airport wait times, Flight Information etc.); 2. Loyalty (i.e SkyMiles related functionality); 3. Booking. Each layer was therefore a shared ownership model (which should be avoided as it becomes a breeding ground for [Diffusion of Responsibility](https://en.wikipedia.org/wiki/Diffusion_of_responsibility).

There was tight coupling across each layer. Although we had pretty decent automated test coverage, our QA team could not be assured that a change in the UI layer from the Booking team, would not potentially introduce an unwanted side-effect across the entire site impacting the other teams. This drove up both the cost of change and the risk. The decision was made to adopt a vertical slice architecture where each slice was under the complete control and ownership of a single team. This implied some code duplication to ensure each vertical slice could be fully self-sufficient and self-contained with zero dependencies on other [vertical slices](https://www.youtube.com/watch?v=_1rjo2l17kI). This felt a little wrong as it went against the grain of "code re-use", but the truth is I would always favor loose coupling over code-reuse. There were some stable common elements where it made complete sense to push down and so we extracted that into a common layer called "Core". The approach worked enabling the teams to work more independently of each other without compromising overall site stability. In fact, the teams wanted even more fine-grained isolation.

We continued to slice the architecture into more fine-grained units. There were features that were very stable and had a low rate of change and we wanted to avoid unnecessary testing where possible (at least until the cost of testing could be lowered). Finally, we evolved the architecture further where each team had their own application server instance providing O/S process isolation. 

Later in my career, I encountered a similar situation. We had a lot of tension around one particular component. For some reason, the PR cycle times were very long. This created frustrations in the form of blockers for the teams involved. Another observation was the large number of people involved in the PRs contributing to lengthy PR cycle times. Initially, I jumped to the (erroneous) conclusion that the PR process was broken and so led an effort to try and fix it. Later, I would discover that the lengthy PR cycle times were merely a symptom of a deeper problem. The problem was that the component was a shared component "owned" by many teams.

Using [CodeScene](https://codescene.com), a "Social Network Analysis" was used to better understand the relationship between team structure and the architecture. The social network graph is built from how the code evolves. The social network paths are mined from how a codebase is developed and by whom. An anonymized version of the social network graph produced is shown in Figure 2.

{{< figure src="socialanalysis.png" title="Figure 2: CodeScene Social Network Analysis" >}}

An ideal state is where a single team (and nobody else) is the only entity working on a part of the codebase. This can be observed for "Team C". The reason why this is an ideal state is because the communication within teams is considered high-bandwidth \[ <sup>2</sup> ]. The team is aligned with the goals and each member will have a shared contextual awareness of all team activities, participating in the same activities, working on the same objectives. Information flows effortlessly within the team. Coordination costs are low. PRs are unlikely to be contentious and drag on for days because there is likely to be a deeper sense of ownership of that area of the codebase. In essence, collaboration is cheap within a team.

From this analysis, we can see Team "A" and Team "B" are working on a shared component. This was the shared component that experienced very lengthy PR cycle times. 

Skelton and Pais [ <sup>2</sup> ] state “The danger of allowing multiple teams to change the same system or subsystem is that no one owns either the changes made or the resulting mess". 

The takeaway from this experience is that a component must be owned by at most one team. 

<p style='text-align: center;'>. . .</p>

_[1]: — [See Conway's Law](https://learningloop.io/glossary/conways-law)_

_[2] M. Skelton and M. Pais, "Team Topologies: Organizing Business and Technology Teams for Fast Flow", IT Revolution Press, Portland, OR, 2019_
