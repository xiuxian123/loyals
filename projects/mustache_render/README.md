= MustacheRender

This project rocks and uses MIT-LICENSE.

## in controller

```ruby
  mustache_file_render '/home/happy/template/deals/index', {:name => 'render?', :age => 12}
  mustache_render 'name:{{name}} age:{{age}}', {:name => 'render?', :age => 12}
```
## in view eg. erb

```ruby
  <%= mustache_file_render '/home/happy/template/deals/index', {:name => 'render?', :age => 12} %>
  <%= mustache_render 'name:{{name}} age:{{age}}', {:name => 'render?', :age => 12} %>
```

## in other

```ruby
require 'mustache_render'
MustacheRender::Mustache.render "Hi! {{name}}", {:name => 'happy!'}
```

