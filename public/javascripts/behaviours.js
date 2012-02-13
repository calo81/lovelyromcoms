// This will have all the javascripts, as it currently for some reason doesn't pick up controller related js

// Sliders in movie edit

$(function() {
       var elements=new Array("couple_chemistry","she_handsome","he_handsome","dream_place","tear_rate","happy_ending","fun_factor","real_life_likely","sex_scenes");
        $.each(elements,function(i,val){
           $("#slider_"+val).slider({
			range: "min",
			value: 0,
			min: 0,
			max: 10,
			slide: function( event, ui ) {
				$("#"+val).val(ui.value );
			}
		});
		$( "#"+val ).val($( "#slider_"+val ).slider( "value" ) );
        });

	});