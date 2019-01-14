# My "Elixir for Programmers" Work

This repo has my work for the Pragmatic Programmers "Elixir for Programmers" class.

You can take this class [here](https://codestool.coding-gnome.com/courses/elixir-for-programmers).

Each subfolder here has one piece of the course, following the approach that Dave took. They are each standalone Elixir apps that work with each other.

Unfortunately, even though the course is less than two years old, it is already out of date, especially for the Phoenix Framework. Here are some issues that I ran into and worked around:

* Phoenix no longer defaults to Bootstrap, but uses Milligram instead. This meant that the grid and alert styles used in both gallows and socket gallows did not work. I just found rough Milligram equivalents.

* Phoenix now uses Webpack instead of Brunch. Can't remember what specific issues this caused, if any.

* The course has bare route helpers, e.g.: ```hangman_path(@conn, :make_move)``` but Phonenix now requires calling this on the `Routes` module: ```Routes.hangman_path(@conn, :make_move)```.

* I had trouble with the JSON library blowing up in the socket channel code. It choked on the MapSet used for the "used letters" in the tally. I think this might be due to Phoenix changing from using Poison to Jason. I worked around it by converting the data structure to a list in the HangmanChannel.

I think there were other issues, but I'm already forgetting what they were.

I REALLY wish that I had started this class as a git repo and done each lesson as a branch. (If Dave updates the class, I think he should recommend that.) I have this record of my complete work, but nothing to tie changes to each lesson.

I also wish the class had more writing of tests, beyond the game module (like controller and socket tests). I fixed or removed any broken tests, so all tests should be green.

I'll add more notes here if I can think of them.

_NOTE:  This code has some bits specific to my environment (at the very least, the "hangman_server" value in the text_client). I'll try to extract these into env vars at some point._
