#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require twitter/bootstrap
#= require sync
#= require_tree .


class Sync.UserListRow extends Sync.View

  beforeUpdate: (html, data) ->
    @$el.fadeOut 'slow', => @update(html)

  afterUpdate: -> @$el.fadeIn('slow')

  beforeRemove: -> @$el.fadeOut 'slow', => @remove()
