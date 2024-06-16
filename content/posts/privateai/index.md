+++
title = 'Private AI'
date = 2024-05-15T10:00:00-04:00
featured_image = "private_ai_architecture.svg"
tags = ['AI']
+++

In July 2023, I knocked up a simple AI chatbot using the open source Llama model from Meta. I coded it up from scratch using [LangChain](https://www.langchain.com). It had the ability to build a vector store from your own proprietary or sensitive documents, enabling you to chat "over them", without risking [un-intentional disclosure](https://www.tomsguide.com/news/samsung-accidentally-leaked-its-secrets-to-chatgpt-three-times). It ran reasonably ok, using a quantized version of Llama, but the main selling point was the complete privacy and zero subscription costs.

I called it Clifton. You can find the code on my [GitHub](https://github.com/jasondchambers/clifton_ai). It was named so, because I was inspired by the concept of Cliff Notes. The idea being, get Clifton to read the documents for you - so you don't have to, and then just have it respond to any questions you may have.

Things have been moving at a rapid pace in the world of AI (Generative AI to be specific). Clifton is now obsolete. A few months ago, I came across [Ollama](https://ollama.com). Combined with [Open WebUI](https://docs.openwebui.com), you can create a private AI experience similar to ChatGPT - but with complete privacy and zero subscription costs. You just need a reasonable machine on-prem on which to run it.

Fortunately, I do have a reasonably powerful machine.

The other problem I needed to solve is, how can I access my private AI while away from home (and away from my home network) using my iPhone? I solved this using a Zero Trust Network Access architecture instead of using a traditional VPN. The service I use is called Twingate.

The architecture of the solution is shown in the following diagram:

{{< figure src="private_ai_architecture.svg" alt="" caption="" >}}

Open WebUI provides a nice experience, very similar to what you might have experienced with ChatGPT. The response time is very good and comparable to what you might experience with ChatGPT:

{{< figure src="openwebui_sample.png" alt="" caption="" >}}

To support roaming, I have the Twingate app installed on my iPhone which I use to connect to Twingate. Note that I am not connecting directly to my private AI server. This is not possible because the private AI server is not reachable from outside my network. All requests to the Open WebUI application are securely relayed by Twingate.

The other issue I had to solve was that the PC hosting my private AI would go to sleep during periods of inactivity. To solve I needed a way to remotely wake it up so I could access Open WebUI. I solved this by creating a wakeup service, using Wake-on-LAN. You can find more details about that on my [GitHub](https://github.com/jasondchambers/wakeupmachine).

To use my Private AI while away from home via my iPhone simply requires me to connect to Twingate (similar to how you might connect to a traditional VPN):

{{< figure src="iphone_twingate.png" alt="" caption="" >}}

Next step requires me to wake up the private AI server:

{{< figure src="iphone_wakeup.png" alt="" caption="" >}}

Notice that my phone is not on WiFI. It is connected to my cell provider. Also notice the IP address of the resource. It is a private RFC 1918 address and is not reachable from outside my network. This is only made possible via Twingate relaying the (secure) connection. If I disconnect from Twingate on my iPhone, I'm no longer able to reach this resource. Also note, that even when connected to Twingate, I'm not able to explore my entire home network - just the resource/apps according to the policy I have set.

Now that it is awake, I am able to connect to the Open WebUI - again relayed via Twingate.

{{< figure src="iphone_openwebui.png" alt="" caption="" >}}

If you want to learn how to get started with Ollama, I recommend [NetworkChuck's video"Host ALL your AI locally"](https://www.youtube.com/watch?v=Wjrdr0NU4Sk). If you decide to follow Chuck's instructions, I recommend using LLama3 instead of Llama2 as suggested in the video.

If you are interested in learning more about Twingate, I recommend this video [The END of VPNs](https://www.youtube.com/watch?v=IYmXPF3XUwo&t=1013s), also from NetworkChuck.
