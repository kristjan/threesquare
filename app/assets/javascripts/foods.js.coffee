# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

ThreeSquare = {} if typeof(ThreeSquare) == 'undefined'

ThreeSquare.Foods =
  init: () -> $('label input').change ThreeSquare.Foods.selectLabel
  selectLabel : (evt) ->
   $('label').removeClass('selected')
   $(evt.target).closest('label').addClass('selected')


$ ThreeSquare.Foods.init
