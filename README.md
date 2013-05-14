Susuwatari
===

Susuwatari (ススワタリ lit. meaning "travelling soot") is the name of the dust bunnies featured in [Studio Ghibli](http://en.wikipedia.org/wiki/Studio_Ghibli) Animes _My Neighbour Totoro_ and _Spirited Away_.


An Introduction for the Impatient (tl;dr)
---

This gem allows you to use the API of Patrick Meenan excellent [webpagetest.org](http://www.webpagetest.org) and fetch scores, numbers and waterfall images.

    require 'susuwatari'

    mei = Susuwatari.new( url: 'google.com', k: '5566sdfdsf' )
    mei.run
    => "aASFDasfdads2"

    mei.status
    => :running

    mei.status
    => :completed

    mei.result.keys
     => [ "test_id", "summary", "test_url", "location", "connectivity",
          "bw_down", "bw_up", "latency", "plr", "completed", "runs", "average",
          "median", "run"]

    mei.result.test_id
    => "aASFDasfdads2"

    mei.result.run.first_view.images.waterfall
    => "http://www.webpagetest.org/results/12/02/09/KG/35XV333/1_waterfall.png"

    mei.result.run.first_view.results.score_cache
    => "98"

    mei.result.run.first_view.results.requests
    => 12

You can check what a result looks like [here](https://sites.google.com/a/webpagetest.org/docs/advanced-features/webpagetest-restful-apis#TOC-Getting-test-results).

So why Susuwatari?
---

Premature optimization might be the root of all evil, but optimizing actual performance bottlenecks is uniquely satisfying.

Optimizing a web page from the end user perspective is even more satisfying, so we figured we need a way to monitor the web page speed on a regular basis.

This gem allows to you test your url using webpagetest.org and get all the relevant numbers (imho) in a structured form. Looking at the waterfall charts allows you to squash all those little nasty dust bunnies that will slow down your page.

![Squashing Susuwatari](http://dl.dropbox.com/u/3878602/ToShare/lk6r97NoeA1qzgeh8o1_500.gif "Squashing Susuwatari")

So how to use it?
---
You need an api key from webpagetest.org to use this gem. You can find more information about that on the [Developer Interfaces Documentation](https://sites.google.com/a/webpagetest.org/docs/advanced-features).

Once you've installed the gem, you can use it like this:

    require 'susuwatari'

    mei = Susuwatari.new( url: 'google.com', k: 'your-key', from: 'detroit', using: 'Chrome')

    mei.run
    => 'aBd333'


    # You can check the status.
    mei.status
    => :running

    mei.status
    => :completed

    mei.result.keys
     => [ "test_id", "summary", "test_url", "location", "connectivity",
          "bw_down", "bw_up", "latency", "plr", "completed", "runs", "average",
          "median", "run"]

    #You can access the results as a hash
    mei.result[:test_id]
    => 'aBd333'

    #Or in a pseudo-object oriented fashion
    mei.result.test_id
    => 'aBd333'

Reviewing Previous WPT Runs
----
You can retrieve the data for a previous Web Page Test run by passing the
results page URL into the :url parameter, and calling the `review_results`
method.

    require 'susuwatari'

    mei = Susuwatari.new( url: 'http://www.webpagetest.org/result/130514_NC_RRZ/', k: '5566sdfdsf' )
    mei.review_results.run.first_view.results.requests
    => 1

Locations
----
To see a list of all the available locations and how you need to pass
the `location` parameter check [locations](http://www.webpagetest.org/getLocations.php)

