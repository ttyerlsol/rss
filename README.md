rss
===

Keywords: Erlang, RSS, Delicious

A very simple Erlang based RSS feed fetcher. It parses the results into a list of item titles. 

Uses httpc, xmerl without any external libraries. 

Installation
------------

$ make

   or

$ make tests

Usage RSS
---------

1> rss:init().

2> rss:url("http://del.icio.us/rss/popular/cats").
{ok,[<<"Spectacular DIY Tree Branch Cat Tree "...>>,
     <<"Kittens and Mom Scenarios and How to Trap - Alley Cat Allies">>,
     <<"This Cat Is Better at Jenga Than Any of You">>,
     <<"Fred The Undercover Kitty">>,
     <<"Boots the cat with only two paws is the cutest ninja ever!">>,
     <<"I wish my kitty were big enough to hug - The Oatmeal">>,
     <<"Superhero Cats | InspireFirst">>,<<"We Love Cats!:">>,
     <<"Lioness Kills Baboon, It"...>>],
    []}

Usage Delicious
---------------

1> rss:init().

2> delicious:popular("pies").
[<<"Teeny Lamothe's Pear & Goat Cheese Tart | Serious Eats : Recipes">>,
 <<"www.howdini.com">>,
 <<"Diabetic Strawberry Rhubarb Pie | ThriftyFun">>,
 <<"Key Lime Pie Recipe | Key Lime Pie with Coconut Crust | Two Peas & Their Pod">>,
 <<"Cuidados para unos pies saludables">>,
 <<"www.ireallylovechocolate.com">>,
 <<"Blackberry Pot Pies Recipe : Ree Drummond : Food Network">>]

