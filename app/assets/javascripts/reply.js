$(document).ready(function() {
	$('.reply').one("click",function() {
		$('.reply_box').append('<textarea rows="3" cols="80"></textarea>');
		$('.reply_box').append('<button>save</button>');
	});
});
