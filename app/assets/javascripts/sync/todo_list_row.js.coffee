class Sync.TodoListRow extends Sync.View

  beforeInsert: ($el) ->
    $el.hide()
    @insert($el)

  afterInsert: -> 
    @$el.fadeIn 'fast'

  beforeRemove: -> 
    @$el.fadeOut 'fast'
    => remove()
