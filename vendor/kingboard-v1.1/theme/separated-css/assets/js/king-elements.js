$(document).ready(function(){

	// if form elements page
 	if( $('body').hasClass('forms-elements') ) {
	 	
		//*******************************************
		/*	masked  input
		/********************************************/

		$('#phone').mask('(999) 999-9999');
		$('#phone-ex').mask('(999) 999-9999? x99999');
		$('#tax-id').mask('99-9999999');
		$('#ssn').mask('999-99-9999');
		$('#product-key').mask('a*-999-a999');


	 	//*******************************************
		/*	switch init
		/********************************************/

		$('.switch-demo, .switch-radio-demo').bootstrapSwitch();

		$('.switch-radio-demo').on('switch-change', function () {
			$('.switch-radio-demo').bootstrapSwitch('toggleRadioState');
		});


		//*******************************************
		/*	multiselect
		/********************************************/

		$('#multiselect1, #multiselect2, #multiselect5, #multiselect6').multiselect({
			maxHeight: 200
		});

		$('#multiselect3-all').multiselect({
			includeSelectAllOption: true,
			buttonClass: 'btn btn-primary'
		});

		$('#multiselect4-filter').multiselect({
			enableFiltering: true,
			enableCaseInsensitiveFiltering: true,
			maxHeight: 200
		});

		$('#multiselect7-addon').multiselect({
			buttonContainer: '<div class="btn-group" />'
		});

		$('#multiselect-color').multiselect({
			buttonClass: 'btn btn-primary'
		});

		$('#multiselect-size').multiselect({
			buttonClass: 'btn btn-default btn-sm'
		});

		$('#multiselect-link').multiselect({
			buttonClass: 'btn btn-link'
		});


		//*******************************************
		/*	input append
		/********************************************/

		$( "form.input-append" ).keypress(function(e) {
			if ( e.which == 13 ) {
				e.preventDefault();
			}
		});

		$('.input-group-appendable .add-more').click(function(){
			$wrapper = $(this).parents('.input-appendable-wrapper');
			$lastItem = $wrapper.find('.input-group-appendable').last(); 

			$newInput = $lastItem.clone(true);

			// change attribute for new item
			$count = $wrapper.find('#count').val();
			$count++;

			// change text input and the button
			$newInput.attr('id', 'input-group-appendable' + $count);
			$newInput.find('input[type="text"]').attr({
				id: "field" + $count,
				name: "field" + $count
			});

			$newInput.find('.btn').attr('id', 'btn' + $count);
			$newInput.appendTo($wrapper);

			//change the previous button to remove
			$lastItem.find('.btn')
			.removeClass('add-more btn-primary')
			.addClass('btn-danger')
			.text('-')
			.off()
			.on('click', function(){
				$(this).parents('.input-group-appendable').remove();
			});

			$wrapper.find('#count').val($count);

		});


		//*******************************************
		/*	slider input
		/********************************************/

		$('.basic-slider').rangeSlider({
			arrows: false
		});

		$('.basic-slider').on('valuesChanging', 
			function(e, data) {
				$('#slider-output')
				.text('Value min: ' + data.values.min + ', ' + 'max: ' + data.values.max)
				.slideDown(300);
			}
		);

		$('.date-slider').dateRangeSlider({
			arrows: false
		});
		
		$('.editable-slider').editRangeSlider({
			arrows: false,
			bounds: {min: 5, max: 50},
			defaultValues: {min: 12, max: 40}
		});

		$('.basic-step-slider').rangeSlider({
			arrows: false,
			step: 10
		});

		$('.basic-label-slider').rangeSlider({
			valueLabels: "change"
		});


		//*******************************************
		/*	color picker
		/********************************************/

		$('#demo1').colorpicker();
		$('#demo2').colorpicker({
			format: 'rgba'
		});
		$('#demo3').colorpicker();

		$('select[name="colorpicker-picker-longlist"]').simplecolorpicker({
			picker: true, 
			theme: 'fontawesome'
		});


		//*******************************************
		/*	spinner input
		/********************************************/

		$("#touchspin1").TouchSpin();
		$("#touchspin2").TouchSpin({
			min: 0,
			max: 100,
			step: 0.1,
			decimals: 2,
			boostat: 5,
			maxboostedstep: 10,
			postfix: '%'
		});

		$("#touchspin3").TouchSpin({
			min: -1000000000,
			max: 1000000000,
			stepinterval: 50,
			maxboostedstep: 10000000,
			prefix: '$',
			prefix_extraclass: '' // dont make it as: btn btn default
		});

		$("#touchspin4").TouchSpin({
			postfix: "Submit",
			postfix_extraclass: "btn btn-custom-secondary"
		});


		//*******************************************
		/*	textarea
		/********************************************/

		var textMax = 99;
		$('.textarea-msg').html(textMax + ' characters remaining');

		$('#textarea').keyup(function() {
			var textLength = $('#textarea').val().length;
			var textRemaining = textMax - textLength;

			$('.textarea-msg').html(textRemaining + ' characters remaining');
		});


		//*******************************************
		/*	date picker
		/********************************************/

		var dtp = $('#datepicker').datepicker()
		.on('changeDate', function(e) {
			dtp.datepicker('hide');
		});	
			
		$('#daterange-default').daterangepicker({
			timePicker: true,
			timePickerIncrement: 10,
			format: 'MM/DD/YYYY h:mm A'
		});
		
		$('#reportrange').daterangepicker({
			startDate: moment().subtract('days', 29),
			endDate: moment(),
			minDate: '01/01/2012',
			maxDate: '12/31/2014',
			dateLimit: { days: 60 },
			showDropdowns: true,
			showWeekNumbers: true,
			timePicker: false,
			timePickerIncrement: 1,
			timePicker12Hour: true,
			ranges: {
				'Today': [moment(), moment()],
				'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
				'Last 7 Days': [moment().subtract('days', 6), moment()],
				'Last 30 Days': [moment().subtract('days', 29), moment()],
				'This Month': [moment().startOf('month'), moment().endOf('month')],
				'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
				},
			opens: 'left',
			buttonClasses: ['btn btn-default'],
			applyClass: 'btn-small btn-primary',
			cancelClass: 'btn-small',
			format: 'MM/DD/YYYY',
			separator: ' to ',
			locale: {
					applyLabel: 'Submit',
					fromLabel: 'From',
					toLabel: 'To',
					customRangeLabel: 'Custom Range',
					daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr','Sa'],
					monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
					firstDay: 1
				}
			},

			function(start, end) {
				console.log("Callback has been called!");
				$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
			
			}
		);

		// set the initial state of the picker label
		$('#reportrange span').html(moment().subtract('days', 29).format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

	} // end if form elements page

	// if flash alert/message page
	if( $('body').hasClass('flash-alert') ) {
		
		// global setting override
		$.extend( $.gritter.options, {
			// you can use these params to set global variable that affect all the notications behaviour
			//class_name: 'gritter-light',
			//fade_in_speed: 100,
			//fade_out_speed: 100,
			//position: 'bottom-right' // possibilities: bottom-left, bottom-right, top-left, top-right
			time: 1500,
		});

		$('#gritter-regular').click( function() {
			$.gritter.add({
				title: 'Regular Alert!',
				text: 'Fades out automatically in amount of time.',
			});
		});

		$('#gritter-sticky').click( function() {
			$.gritter.add({
				title: 'Sticky Alert!',
				text: 'You have <a href="#">new support message</a>. Click (x) on the top right to close this message.',
				sticky: true
			});
		});

		var flashMsgSound = new Audio();
		var offlineSound = new Audio();

		if ( navigator.userAgent.match("Firefox/") ) {
			flashMsgSound.src = "assets/audio/flash-message.ogg";
			offlineSound.src = "assets/audio/offline.ogg";
		}else {
			flashMsgSound.src = "assets/audio/flash-message.mp3";
			offlineSound.src = "assets/audio/offline.mp3";
		}

		$('#gritter-image').click( function() {
			$.gritter.add({
				title: 'Jane Doe',
				text: 'Online',
				image: 'assets/img/user3.png',
				time: 2000,
				after_close: function() {
					$.gritter.add({
						title: 'Jordan Smith',
						text: 'Offline',
						image: 'assets/img/user5.png',
						time: 2000
					});

					if( $('#gritter-sound-switch').is(':checked') ) {
						offlineSound.play();
					}
				}
			});
		});

		$('.btn-gritter').click( function(){
			
			if( $('#gritter-sound-switch').is(':checked') ) {
				flashMsgSound.play();
			}
		})

		$('#gritter-callback').click( function() {
			$.gritter.add({
				title: 'Callback',
				text: 'Provide several callback features',
				time: 1000,
				before_open: function() {
					alert('before_open callback');
				},
				after_open: function() {
					alert('after_open callback');
				},
				before_close: function() {
					alert('before_close callback');
				},
				after_close: function() {
					alert('after_close callback');
				},
			});
		});

		$('#gritter-max').click( function() {
			$.gritter.add({
				title: 'Limit Notifications',
				text: 'This is a notice with a max of 3 on screen at one time!',
				before_open: function() {
					if( $('.gritter-item-wrapper').length == 3 ) {
						// Returning false prevents a new gritter from opening
						return false;
					}
				}
			});

			return false;
		});

		$('#gritter-light').click( function() {
			$.gritter.add({
				title: 'Light Theme!',
				text: 'If you want the light version, you got it. Just add option class_name: \'gritter-light\' :)',
				class_name: 'gritter-light',
			});
		});

		$('.btn-gritter-position').click( function() {

			// clean the wrapper position class
			$('#gritter-notice-wrapper').attr('class', '');

			// global setting override
			$.extend( $.gritter.options, {
				position: '' + $(this).attr('id') + '' // possibilities: bottom-left, bottom-right, top-left, top-right
			});

			$.gritter.add({
				title: $(this).find('span.title').text(), // could be simpler, just for demo purposes
				text: 'Hi, I\'m on the  ' + $.gritter.options.position + ''
			});
		});
		 
	} // end if flash alert page

	// if general ui elements page
	if( $('body').hasClass('general-ui-elements') ) {

		//*******************************************
		/*	bootstrap progress bar by @minddust
		/********************************************/

		if( $('.progress .progress-bar').length > 0 ) {
			$('.progress.demo-only .progress-bar').progressbar({
				display_text: 'fill'
			});
			
			$('.progress.no-percentage .progress-bar').progressbar({
				display_text: 'fill',
				use_percentage: false
			});

			$('.progress.custom-format .progress-bar').progressbar({
				display_text: 'fill',
				use_percentage: false,
				amount_format: function(p, t) {return p + ' of ' + t;}
			});

			$('.progress.vertical .progress-bar').progressbar();
			$('.progress.vertical.demo-only .progress-bar').progressbar({
				display_text: 'fill'
			});
		}
		
	} // end if general ui elements

	// if dropzone exist
	if( $('.dropzone').length > 0 ) {
		Dropzone.autoDiscover = false;
		
		$(".dropzone").dropzone({
			url: "php/dropzone-upload.php",
			addRemoveLinks : true,
			maxFilesize: 0.5,
			maxFiles: 5,
			acceptedFiles: 'image/*, application/pdf, .txt',
			dictResponseError: 'File Upload Error.'
		});
	} // end if dropzone exist

	if( $('body').hasClass('form-val') ) {
		
		// validation needs name of the element
	 	$('.multiselect-validation').multiselect({
	 		inputItemName: 'food'
	 	});
	}

}); // end ready function