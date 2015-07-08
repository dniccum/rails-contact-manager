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

$('.modal-trigger').leanModal();

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

	if (value.length >= 2) {

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

$('.details-modal-trigger').click(function() {
    var id = $(this).data('id');

    $.ajax({
        type: 'get',
        url: '/contacts/details/' + id,
        success: function(response) {
            var name = response.first_name + ' ' + response.last_name;
            if (response.image) {
                var details = '<div class="row"><div class="col l3 m4 s12"><img class="circle responsive-img" src="' + response.image.url + '" /></div><div class="col l9 m8 s12"><h5>Email</h5><p>' + response.email + '</p>';
            } else {
                var details = '<h5>Email</h5><p>' + response.email + '</p>';
            }

            if (response.company) {
                details += '<h5>Company</h5><p>' + response.company + '</p>';
            }
            if (response.notes) {
                var notes = response.notes.replace(/(?:\r\n|\r|\n)/g, '<br />');
                details += '<h5>Notes</h5><p>' + notes + '</p>';
            }
            if (response.image) {
                details += '</div></div>';
            }

            $('#details-modal .name').text(name);
            $('#details-modal .contact-details').html(details);
            $('#details-modal').openModal();
        },
        error: function(error) {
            Materialize.toast('There was a problem with your request.', 3000, 'red');
        }
    });

    return false;
});
