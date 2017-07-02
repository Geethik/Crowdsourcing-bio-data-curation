# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> $("table.special").dataTable()

jQuery -> $('#AE_check').change ->
            if(this.checked)
                $('#AE_filters').fadeIn('slow');
            else
                $('#AE_filters').fadeOut('fast');

jQuery -> $('#GEO_check').change ->
            if(this.checked)
                $('#GEO_filters').fadeIn('slow');
            else
                $('#GEO_filters').fadeOut('fast');