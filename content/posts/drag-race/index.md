+++
title = 'Drag Race - Azure vs Google Cloud'
date = 2024-04-28T11:00:52-04:00
featured_image = "dragrace.png"
+++

After over a decade working AWS, during my "sabbatical" I've had the opportunity to go multi-cloud and play around with Azure and Google Cloud. I've built 3 websites in recent months - all containerized, stateless and static. These are simple workloads, and due to the use of containers (and their stateless nature), they are highly portable. This has provided me the opportunity to do some comparisons. I'm cheap and so I optimized their deployment for cost trying to make them as cheap as possible (I've succeeded). I've traded performance for economy effectively using zero replicas. This implies a cold-start for the first request which, for low volume websites such as mine can be noticeable. When zero activity is observed, it scales back down to zero (containers). Again, for a low-volume web-site, the probability of a cold-start is typically high.

I noticed that Azure seems to take a while for the container to start up from a cold start. A very long while to be honest. For Google Cloud, I didn't really notice the cold start cost at all. For this reason, for my particular work-loads, to preserve low-cost and increase user experience, I've deployed all of my websites on Google Cloud.

{{< figure src="dragrace.png" alt="Cold start performance" caption="Cold start performance" >}}

This does not mean Google Cloud is better than Azure. I'm using a very small slither of what public cloud providers can offer. It just means, for my particular requirements which are likely to be quite different from yours, Google Cloud provides better performance. Once the containers are "warm", the performance difference is negligible.

Similar to those Carwow drag races you may have seen on YouTube (ok, maybe it's me and a couple of other car nuts who watch those :-), take my findings with a grain of salt.

Additional observation: I have found all of the cloud consoles to be clunky things to navigate.
