# Beyond the Model: Operationalizing 4,586 Bigfoot Sightings

Bigfoot has been a staple of American folklore since the 19th century. Many people are convinced that Bigfoot is real. Others suggest that he is a cultural phenomenon. Some just want to believe. There is even a group, the Bigfoot Field Researchers Organization, that tracks Bigfoot sightings. And they have thousands of reports available online that date back to the late 19th century.

The Internet, it seems, has everything.

So, I took this data, all 4,586 records of it, and used it to build a classifier. It was a good model with pleasing metrics. I liked it. But what next? For some folks, the model is where the work ends. But I'm a developer and that's only half the solution. I've got a model. Now, how do I use it? How to I put it in an application so that a user can, well, use it?

I'm going to answer that question and a bit more. I'll show you how I exposed my Bigfoot classifier to the Internet via a REST-based API written in Python. And we'll tour a couple of applications I wrote to use that API: a web-based application written in JavaScript, and an iOS application written in Swift. For the model itself, I'll use DataRobot since it's quick and easy and I work there!

When we're done, you'll know how to incorporate a model into an API of your own and how to use that API from your application. And, since all my code is on GitHub, you'll have some examples you can use for your own projects. As a bonus, you'll have 4,586 records of Bigfoot sightings to play with. And who doesn't want that?
