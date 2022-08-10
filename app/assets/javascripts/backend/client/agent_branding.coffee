# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# require tour coffee script for load avatar input function
#= require backend/tour
ready = ->

  # scroll down to nav
  #$("html, body").animate({ scrollTop: $("ul.nav-tabs").offset().top - 50 }, 1000);

$(document).ready(ready);
$(document).on('page:load', ready);