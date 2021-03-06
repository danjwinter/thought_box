$(document).ready(() => {
  $('.links').on('click', '.read', (e) => {
    e.preventDefault();
    let linkDiv = $(e.target.parentElement.parentElement);
    let readStatus = linkDiv.find('.read-status');
    let id = readStatus.data("id");
    let target = e.target;
    $.ajax({
      type: "PUT",
      url: `/api/v1/links/${id}`,
      data: {link: {read: false}},
      success: () => {
        readStatus.text('Read: false');
        target.innerHTML="Mark as Read";
        linkDiv[0].style.color = "black";
        target.parentElement.className= "unread";
      }
    });
  });
  $('.links').on('click', '.unread', (e) => {
    e.preventDefault();
    let linkDiv = $(e.target.parentElement.parentElement);
    let readStatus = linkDiv.find('.read-status');
    let id = readStatus.data("id");
    let target = e.target;
    $.ajax({
      type: "PUT",
      url: `/api/v1/links/${id}`,
      data: {link: {read: true}},
      success: () => {
        readStatus.text('Read: true');
        linkDiv[0].style.color = "grey";
        target.innerHTML="Mark as Unread";
        target.parentElement.className = "read";
      }
    });
  });
searchForLink();
filterByReadStatus();
filterByUnReadStatus();
showAll();
sortAlphabetically();
});

var searchForLink = function(){
  $('#search').on('keyup', function(e){
    e.preventDefault();

    var query = $(this).val();
    var links = $('.link');
    $.each(links, function(index, link){
      showIdeasMatchingQuery(link, query);
    });
  });
};

var showIdeasMatchingQuery = function(link, query) {
  var title = $(link).find('.title').text();
  var url = $(link).find('.url').text();

  var matchesSearchTerm = title.includes(query) || url.includes(query);
  $(link).toggle(matchesSearchTerm);
};

var filterByReadStatus = function() {
  $('.filter-by-read').on('click', (e) => {

    var links = $('.link');

    $.each(links, (index, link) => {
      var readStatus = $(link).find('.read-status').text();
      var matchesSearchTerm = readStatus.includes("Read: true");
      $(link).toggle(matchesSearchTerm);
    });
  });
};

var filterByUnReadStatus = function() {
  $('.filter-by-unread').on('click', (e) => {
    var links = $('.link');

    $.each(links, (index, link) => {
      var readStatus = $(link).find('.read-status').text();
      var matchesSearchTerm = readStatus.includes("Read: false");
      $(link).toggle(matchesSearchTerm);
    });
  });
};

var showAll = function() {
  $('.show-all').on('click', (e) => {
    var links = $('.link');

    $.each(links, (index, link) => {
      $(link).show();
    });
  });
};

var sortAlphabetically = function() {
  $('.sort-alphabetically').on('click', (e) => {
    var links = $('.link');
    var alphaSortedLinks = links.sort((a, b) => {
      return $(a).find(".title").text() > $(b).find(".title").text();
    });
    $('.links').html(alphaSortedLinks);
  });
};
