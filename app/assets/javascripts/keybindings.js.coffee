$ ->
  handleKeyBindings()

$(document).on 'turbolinks:load', ->
  handleKeyBindings()

handleKeyBindings = ->
  # Elements that, when active, do not trigger a page change
  blacklist = [ "input", "select" ]
  # Key-to-url bindings
  bindings = {}

  # Store all `data-keybinding` attributes with their corresponding URLs
  $('a[data-keybinding]').each (i, el) ->
    key = $(el).data("keybinding")
    bindings[key] = $(el).attr('href')

  # Detect a keypress and navigate to the proper URL if appropriate
  $('body').keypress (e) ->
    if bindings[e.key] != undefined and !$(document.activeElement).is(blacklist.join(","))
      window.location.href = bindings[e.key]
