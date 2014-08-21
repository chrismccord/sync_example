@Todo =
  
  init: -> @bind()

  bind: ->
    $("[data-name=new-todo-form]").on 'ajax:complete', -> @reset()
    $(document).on "click", "[data-action=edit-todo]", (e) =>
      e.preventDefault()
      @toggleEditRow $(e.target).parents(".todo-row")


  toggleEditRow: ($parentRow) ->
    $parentRow.toggleClass("edit")
    $parentRow.find("input[type=text]").focus()



$ ->
  Todo.init()