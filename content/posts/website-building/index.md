+++
title = 'Building a Website From Scratch'
date = 2024-04-17T11:00:52-04:00
featured_image = "stratfordremodel.jpeg"
+++

Two months ago, I decided I wanted to build a couple of websites. For one of the websites, I wanted a place where I could publish my articles. That particularly website is called [circleinaspiral.com](https://circleinaspiral.com). Maybe it is where you are reading this articile right now. This particular article is not about [circleinaspiral.com](https://circleinaspiral.com). Instead, it is for a website to be used to document a recent house remodel my wife and I undertook during 2023.

In this article, I want to share details of the entire process from concept to finished website. I want to share some of the decisions I made and the reasoning behind those decisions. I want to share the trade-offs. At the time of writing, the site is now live and you can view it at [stratfordremodel.com](https://stratfordremodel.com).

At the end, I summarize the take-aways you might consider for whatever your next project might be.

## The Concept

The design concept is similar to those historical pictures you may have seen on the web that show a photo of how the place looked in the past and a photo of how it looks today from the same point of view. A slider enables the viewer to compare before and after without having to adjust their gaze. That was the kind of experience I wanted to created. I wanted it to be accessible from mobile devices. 

{{< figure src="stratfordremodel.jpeg" alt="The initial design concept involving sliders to show before and after" caption="The initial design concept involving sliders to show before and after" >}}

There are sites that make it very easy to achieve this effect, but I wanted an opportunity to learn something new along the way. I find it quite fulfilling to create your own with complete control. Also, I wanted to explore if I could avoid yet another monthly subscription.

## The Requirements

As I thought about the website, I thought about what the requirements needed to be.

### Low cost

The website has to be as cheap as possible to run. Ideally $0-5/month.

### Low maintenance

The website has to be very low maintenance. I anticipate re-entering the workforce at some point and I will not have the time to babysit the website. 

It's quite easy to index on one of these requirements. For example, if all I needed was low maintenance and didn't care too much about the cost, there are plenty of SaaS offerings I could choose from. If all I needed was low cost, I could avoid subscription costs and do everything myself - but this may give me a maintenance headache.

The challenge is striving towards something that is both low cost AND low maintenance. Can it be done? Read on to find out.

### Secure by design

I need to practice what I preach. The website needs to be robust and have a decent security posture. It needs to be safe for the visitors of the website.

## Decisions 

### Development decision - build it myself

The initial decision I made was to build it myself and avoid any specialized SaaS services. To achieve low maintenance, although I don't anticipate adding lots of new features in the future, I don't want to be spending hours just to maintain the site. A good place to start therefore, is to avoid if at all possible relying on a substantial number of dependencies. Attacks on the software supply chain (SSC) have increased significantly over the years. According to [Sonatype](https://www.sonatype.com/resources/software-supply-chain-management-part-3-a-shifting-industry), there was a 650% increase in the number of cyber attacks aimed at open source suppliers in 2021. I wanted to avoid having to continuously patch and update the website with security fixes if at all possible. From my experience, for a project with a substantial number of dependencies you can spend a lot of time and money simply keeping the stack up to date to address vulnerabilities.

The initial decision therefore was to keep things as simple as possible, relying on HTML, CSS and minimal hand-coded JavaScript with zero run-time dependencies. I would come to revisit this decision later in the process.

### Deployment decision - deploy in the cloud (Azure)

This was not an easy decision to make. I have plenty of compute and storage capacity at home for such a small volume website. I entertained the idea of self-hosting using my own equipment. This option was appealing at first because it meant I could avoid ongoing monthly subscription costs. After much careful analysis, I decided however that I would deploy in the cloud.

To inform the decision, I did some threat modeling exercises. I also estimated the availability of the web site. At home, we are subject to power outages and cable provider outages. I have some resilience against power outages as I have an uninterruptible power supply. However, extended power outages and cable provider outages would have an impact on availability. Of course, I could engineer some solution to network availability by using network devices that have cellular failover. However, that would drive up the cost.

It also felt wasteful keeping the lights on so to speak for the website with such a small anticipated trickle of requests.

The big decider though against hosting on-prem (at home), was revealed during my threat modeling exercises. My wife works from home (I will too once I find a new job :-). I cannot afford any disruption to her ability to get work done. Hosting a public facing website certainly increases the attack surface area and puts at risk her ability to continue to work. Of course, I could mitigate by segmenting and isolating the home network to contain any threat should the website get compromised. These techniques would inhibit lateral movement if an attacker gained a foothold on my network through the website. Not sure why anyone would target my little website with a DDOS attack, but that could certainly affect my wife's ability to get her work done.

In the end, I decided it just wasn’t worth it to pursue on-premise deployment at home for my particular case. The decision was to go with the cloud.

The next decision was which cloud? Professionally, I have plenty of experience with AWS. Recall that I wanted an opportunity to learn something new. For [circleinaspiral.com](https://circleinaspiral.com), I chose Google Cloud. For [stratfordremodel.com](https://stratfordremodel.com), I decided to use Azure which I had never used before. This would give me an opportunity to compare and contrast my experiences across all 3 major public cloud providers.

### Unit of deployment decision - container

There are many options for deploying a static website. As an example, I could consider storing the content in an [S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteEndpoints.html#website-endpoint-examples) and configuring it as a static website. I could also consider spinning up a virtual machine in the cloud, and deploying the website on it directly. None of these approaches sounded appealing to me. I'm a big fan of containerized workloads as it greatly simplifies portability in addition to simplifying the build pipeline. All of the 3 major public cloud providers make it pretty easy to deploy containerized workloads. This was an easy decision to make for my particular situation. 

If I chose in the future to move away from Azure and use something else, it would be fairly trivial to lift and move.

### Task management tool decision - GitHub projects

As the sole developer, GitHub Projects are a perfect fit to manage my backlog and TODOs. I quite like and have lots of experience with Jira and I think this makes more sense for a larger team, but it seemed overkill for my simple requirements.

### CI/CD platform decision - GitHub Actions

I (like much of the world today) use GitHub to store my code repos. It makes sense, at least to me, to use GitHub as a CI/CD platform too. My deployment pipeline basically involves triggering a build when I push up new changes, building it and then publishing the container image to DockerHub and Github Packages. I could of course automate all the way to production, but I decided at least for now just to publish the container images. For deployment, I wanted to use the opportunity to experience the Azure Portal with each deployment so that I can gain familiarity with it. Eventually, I may consider to streamline this final production step.

### DNS Registrar decision - Squarespace

Azure grants you a generated domain name for accessing your containers, however they are long and cryptic. I wanted my own custom domain for the website. I chose Squarespace and have been very happy with my decision. You can of course use Squarespace for building and hosting a complete website, but they also offer DNS registrations too and enable you to point your new domain to wherever and whatever you choose. Their support I found to be very good. It's fairly straightforward to bring your own domain to Azure and associate it with your container - you just have to go through a process of establishing trust between all parties which typically involves adding a TXT record to your domain name to assert that you own the domain. 

### Allow or Disallow unencrypted traffic decision - TLS only

I decided to make my website accessible only via TLS (HTTP/S). Over the past 10 years, it has been considered [a best practice](https://www.youtube.com/watch?v=cBhZ6S0PFCY) to ensure all communication is secure by default. This means the website will not be accessible over HTTP - it will be redirected to HTTP/S.


## The Process

When we bought the house, I saved off the original listing photos. I knew we would be modifying the property over the coming years (I didn't anticipate by how much - but that's another story for another day). Once the remodeling project was complete, I attempted to take the same photo from the same spot for each original listing photograph. This would give me the basis for the before and after photographs.

Before I pushed the photos to the repo, I stripped off EXIF data from the images to protect the privacy of the location. Of course, this by itself doesn't guarantee the location is private, it just requires more effort for someone to figure out the location of the photos. I wrote a quick and dirty tool called [Photoprivacyshield](https://github.com/jasondchambers/photoprivacyshield) for this purpose.


## Performance Optimization

Version 1.0 met all my initial requirements. I learned a lot during the process. The issue was, I wasn't terribly happy with the performance. Detailed below are the performance optimizations I made to address this issue.

### Reducing the cold start penalty

To keep the costs low, the minimum number of replicas is set to 0. This means, as a low-volume website, there is a high likelihood of a cold start penalty. I’m ok with this because this is both a cost optimization (I’m not getting billed for 0 replicas) and a resource optimization (I’m not consuming power during periods of inactivity). However, I wasn't happy with the cold start penalty.

I explored if there was a way to reduce the container image size. The smaller the container image, surely the faster to start from cold, reducing the delay. Fortunately, there was.

I took the "after" photos using my iPhone. The quality of the camera is very high resulting in high resolution images. In fact, for the web, the resolution was too high. I wrote a script using [ImageMagick](https://imagemagick.org) to quickly and easily re-scale the images in batch. Using this technique, I was able to reduce the container image size to 32.45 MB (compressed) from its original size of 119.93 MB yielding a 72% space saving.

### Page load time too slow

The website is a single HTML file. It is image heavy with 58 **img** tags. The web-site is not functional until it has completed loading all the images on the page. Serving locally, it takes 1.13s to load on my machine. When you combine the cold start and network latency, the load time is likely to be several seconds. This is not a great experience causing the site visitor to think that perhaps the site is either down or is slow.

I wanted to avoid pagination. This is a dated approach in my opinion. I wanted to preserve the “infinite” scrolling capability as the site visitor explores the website similar to what Instagram provides.

The approach I began to explore was lazy loading. It’s likely, the website visitor may not even view all of the images - and so, it is wasteful to load them. So, the way it works in essence, is the images are only loaded once they are scrolled into view. The question is how do I implement this feature? I can throw some JavaScript together, but in no way do I claim to be a specialist UI developer.

I had an original intent to avoid large frameworks and dependencies. Recall from earlier, I wanted to avoid them to make the website as maintenance free as possible. However, weighing the cost of rolling my own versus using robust tried and tested frameworks that offer lazy loading as a feature, I decided to back-track my original decision and use a framework. The framework I selected was [Svelte](https://svelte.dev). I am new to Svelte, but have heard good things about the developer experience it provides. I thoughts I would give it a shot using this [guide](https://css-tricks.com/lazy-loading-images-in-svelte/#:~:text=svelte%20%2C%20we%20tell%20our%20browser,to%20the%20element.&text=This%20lets%20modern%20and%20future,of%20the%20lazy%20loading%20natively) to solve my specific problem..

With Svelte, I was able to get the load time down to 223 ms (from 1.13s) yielding a 5x performance boost. The other images are only loaded when the user scrolls them into view.

Using Svelte, I was quite happy with the elegance of my application source code. I built a custom Svelte component called "BeforeAfter" that encapsulated all the CSS and JavaScript to implement the slider and lazy loading. You can hopefully see from the source code of the main application below, how easy it would be to add new before/after photographs.

{{< figure src="svelte.png" alt="My first Svelte App" caption="My first Svelte App" >}}

With the introduction of Svelte, I had to re-factor my build process. I wanted to reduce the run-time dependency as much as possible. This was quite straightforward for a simple static website. To build a Svelte app, brings in a lot of dependencies. I did not want these dependencies to be folded into my container image. Fortunately, there is a solution to this problem and that is [multi-stage builds](https://docs.docker.com/build/building/multi-stage/).


## Summary

To summarize, there are several take-aways you might want to consider for your next project whatever it might be.

These are:

1. What are the requirements? What do you value? This will help expedite any inevitable trade-off decisions you will have to make as you progress.
2. Design the user experience you want to create upfront. And then, figure out how you might implement the experience.
3. Threat Modeling. I can't emphasize how important this is. It will enlighten you and your team, bring people together and again, will help guide your project. If you need help, I recommend you reach out to [Devici](https://devici.com).
4. Try and keep things as simple as possible for as long as possible. 
5. Embrace Secure by Design principles.
6. Consider performance optimization only if and when needed.
7. Automate as much as possible to make it easy for you.
8. Consider using containers as the unit of deployment. It increases cloud portability, and as your application expands in scale or complexity, you can consider [k8s](https://kubernetes.io) to orchestrate when the time is right.
8. Have fun.
