lastedit = null;
lastpreview = false;

updatepreview = (object, data, textStatus, XMLHttpRequest) -> 
	$("#preview_box").html(object);

dosummarize = -> 
	autosummarize_enabled = $("#content_block_autosummarize").attr("checked")
	if autosummarize_enabled
		text = $("#content_block_bodytext").val();
		if (text.length <= 140)
			$("#content_block_summary").val(text);
		else
			$("#content_block_summary").val(text.slice(0, 116) + "...");
		countupdate();

countupdate = ->
	$("#summary_count").html($("#content_block_summary").val().length + 22);

dopreview = -> 
	preview_enabled = $("#content_block_preview").attr("checked")
	if preview_enabled
		lasteditdelay = ((new Date() - lastedit) > 1000) || (lastedit == null);
		if ( lasteditdelay && ( !lastpreview ) )
			lastpreview = true;
			$.ajax
				data: {
						'redcloth': $("#content_block_bodytext").val(),
						'authenticity_token': AUTH_TOKEN
					},
				dataType: "text",
				type: 'POST',
				success: updatepreview,
				url: "/content_blocks/preview"

$(document).ready( ->
	setInterval(dopreview, 100);
	$("#content_block_bodytext").keyup(-> 
		lastedit = new Date();
		lastpreview = false;
		dosummarize()
	)
	$("#content_block_summary").keyup(->
		countupdate()
	)
	dopreview();
	dosummarize();
	countupdate();
)