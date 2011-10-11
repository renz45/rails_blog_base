# Rails Blog Base

Base Rails project used to construct a small to medium site with an integrated blog.

Admin will have similar functionality to wordpress (only the blog portion), built to accept other admin sections
along with the blog.

## Purpose
  * All basic functionality included
  * blog
  * authentication
  * basic models/controllers/views for blog)
  * back/front end helper builders for post CRUD (similar to paginate_me, form_for)

## Misc
Might possibly be built into an engine in the future to make it a little more modular and able to be stuck onto an existing site easier. 

### Why am I building this?
Well, I currently use wordpress for my blog, but I'm really not a fan of wordpress. I wanted something I could use
for myself as well as clients as an alternative to wordpress. I hope to be able to stick the bulk of this project into an engine to make it really modular, and/or a generator.

I plan on using markdown to format blog posts, as opposed to a rich text editor such as tinymce. I feel that the rich text editor in wordpress is hard to use, I've had people complain about it inserting extra characters and being a general pain a lot of the time. Markdown is an easy to learn formatting language which anyone should be able to pick up very quickly, especially with some sort of built in syntax reference.