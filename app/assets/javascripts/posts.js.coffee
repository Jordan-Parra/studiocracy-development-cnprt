$ ->
  $('.pagination').infinitePages
    loading: ->
      $(this).text('Loading more posts...')
    error: ->
      $(this).button('Error loading posts.')