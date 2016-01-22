$ ->
  split = (val) ->
    val.split /\s*,\s*/


  extractLast = (term) ->
    split(term).pop()


  allButLast = (term) ->
    list = split(term)
    list.pop()
    list


  $("#user_interest_list").bind("keydown", (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete("instance").menu.active
      event.preventDefault()
    return
  ).autocomplete
    delay: 500
    source: (request, response) ->
      $.getJSON("/interests.json", {
        term: extractLast request.term
        exclude: allButLast request.term
      }, response);
    search: ->
      term = extractLast(@value)
      return false if term.length < 3
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
