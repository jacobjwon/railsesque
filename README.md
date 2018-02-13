# Railsesque

Railsesque is a Ruby Controller and Views framework that uses a Postgresql database and was inspired by Ruby on Rails.

## Key Features

### RailsesqueController

Controllers that inherit from RailsesqueController have the following methods:

* `render(template_name)`: renders a template within the views folder with the corresponding controller name.
* `render_content(content, content_type)`: renders using a custom content type.
* `redirect_to(url)`: redirects to the specified url.
* `session`: accesses the session hash containing the session cookie.
* `flash` and `flash.now`: accesses the hash containing errors that persist through the next session and the current session, respectively.


You can also add `protect_from_forgery` to your custom controllers to protect from CSRF attacks. Add the following input tag to your form:

```html
  <input type="hidden"
  name="authenticity_token"
  value="<%= form_authenticity_token %>">
```
Then, by having `protect_from_forgery` in your custom controllers, Railsesque` will check for the above authenticity token.

### Router

The `Router` can be used to map routes between the controllers and the views.

```Ruby
router = Router.new
router.draw do
  get Regexp.new("^/movies$"), MoviesController, :index
  post Regexp.new("^/movies$"), MoviesController, :create
  get Regexp.new("^/movies/(?<movie_id>\\d+)/Actors$"), ActorsController, :index
end
```

### Rack Middleware

* `Exceptions` were added to provide a detailed description of the Ruby source error. This was intended to provide information to developers in the development environment.

* `Static` were added to allow for the rendering of a static asset from the `/public` folder. Currently, .jpg, .png, .htm, .html, .txt, and .zip extensions are supported.

## Demo Instructions

1. Make sure [Ruby](https://www.ruby-lang.org/en/) is up-to-date
1. `git clone https://github.com/jacobjwon/railsesque.git`
1. `cd railsesque`
1. `bundle install`
1. `ruby items.rb`
1. Visit `http://localhost:3000`
