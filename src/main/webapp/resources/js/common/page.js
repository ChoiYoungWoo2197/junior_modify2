function paging(href) {
	alert(href + ' : ' + encodeURI(href));
	
	location.href = encodeURI(href);
}
