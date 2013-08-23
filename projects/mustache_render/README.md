= MustacheRender

This project rocks and uses MIT-LICENSE.

## in controller

```
  mustache_file_render '/home/happy/template/deals/index', {:name => 'render?', :age => 12}
  mustache_render 'name:{{name}} age:{{age}}', {:name => 'render?', :age => 12}
```
## in view eg. erb

```
  <%= mustache_file_render '/home/happy/template/deals/index', {:name => 'render?', :age => 12} %>
  <%= mustache_render 'name:{{name}} age:{{age}}', {:name => 'render?', :age => 12} %>
```

