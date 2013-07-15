// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
		$( "#slider-couple-chemistry" ).slider({
			range: "min",
			value: 10,
			min: 1,
			max: 700,
			slide: function( event, ui ) {
				$( "#amount" ).val( "$" + ui.value );
			}
		});
		$( "#amount" ).val( "$" + $( "#slider-range-min" ).slider( "value" ) );
	});