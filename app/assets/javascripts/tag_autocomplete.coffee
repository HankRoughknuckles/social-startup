$ ->
  split = (val) ->
    val.split /\s*,\s*/


  extractLast = (term) ->
    split(term).pop()


  allButLast = (term) ->
    list = split(term)
    list.pop()
    list


  $(".interests").bind("keydown", (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete("instance").menu.active
      event.preventDefault()
    return
  ).autocomplete
    source: (request, response) ->
      $.getJSON("/interests.json", {
        term: extractLast request.term
        exclude: allButLast request.term
      }, response);
    search: ->
      # custom minLength
      term = extractLast(@value)
      if term.length < 2
        return false
      return
    focus: ->
      # prevent value inserted on focus
      false
    select: (event, ui) ->
      terms = split(@value)
      # remove the current input
      terms.pop()
      # add the selected item
      terms.push ui.item.value
      # add placeholder to get the comma-and-space at the end
      terms.push ""
      @value = terms.join(", ")
      false
