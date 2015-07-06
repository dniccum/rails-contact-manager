// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require materialize/dist/js/materialize

$(".dropdown-button").dropdown({
    hover: true
});

$('.delete-modal-trigger').click(function() {
    var id = $(this).data('id');
    var name = $(this).data('name');

    $('#contact-to-delete').val(id);
    $('#delete-modal span.name').text(name);
    $('#delete-modal').openModal();

    return false;
});

$('#clear-search').click(function() {
	$('#contact-search').val('');
	$('#clear-search').hide();
	$('#contact-list').html(existingList);
});

$('#search_keywords').keyup(function() {
	var value = $(this).val(),
		visible = $('#clear-search').is(':visible');
	if (value !== '' && !visible) {
		$('#clear-search').fadeIn(100);
	} else if (value === '' && visible) {
		$('#clear-search').hide();
	}

	if (value.length >= 3) {

		$.ajax().abort();

		$.ajax({
			type: 'get',
			url: '/contacts/search?term=' + value,
			success: function(response) {
                console.log(response);
				$('#contact-list').html('');
				if (response.length >= 1) {
					$.each(response, function(key, value) {
						var newRow = '<tr data-id="' + value.id + '">' +
							'<td>' + value.first_name + '</td>' +
							'<td>' + value.last_name + '</td>' +
							'<td>' + value.company + '</td>' +
							'<td></td>' +
						'</tr>';
						$('#contact-list').append(newRow);
					});
				} else {
					$('#contact-list').html('<tr class="no-results status"><td colspan="5">We could not find any results. Please note all searches are case-sensitive.</td></tr>');
				}
			}
		});
	} else {
		// resets view
		$('#contact-list').html(existingList);
	}
});
