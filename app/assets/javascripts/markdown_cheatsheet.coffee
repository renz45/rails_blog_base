$(document).ready ->

  markdown_cheatsheet = 
    expand_definition_for: (that) ->
      this.close_all()
      def = $(that).next('dd')
      def.animate {'height': def.find('>div').outerHeight()},'100'
    close_all:  ->
      $('.markdown_cheat_sheet dd').animate({'height': '0'})
    close_help: ->
      $('.markdown_cheat_sheet').animate {'height': 0}, ->
        markdown_cheatsheet.close_all()
    open_help: ->
      $('.markdown_cheat_sheet').animate {'height': $('.markdown_cheat_sheet dl').height() + 40}, ->
        $('.markdown_cheat_sheet').height('auto')
    toggle_help: ->
      cheat_sheet = $('.markdown_cheat_sheet')
      if cheat_sheet.height() > 0
        this.close_help()
      else
        this.open_help()


  ####################################
  #             bindings             #
  ####################################

  # markdown cheatsheet accordian functionality
  # open matching definition when a term is clicked
  $('.markdown_cheat_sheet dt').bind 'click', ->
    if $(this).next('dd').height() > 0
      $(this).next('dd').animate({'height': 0})
    else
      markdown_cheatsheet.expand_definition_for(this)
  
  #close cheatsheet
  $('.markdown_cheat_sheet .close').bind 'click', ->
    markdown_cheatsheet.close_help()
    return false
  #open cheatsheet
  $('.markdown_help').bind 'click', ->
    markdown_cheatsheet.toggle_help()
    return false