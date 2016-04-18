$(document).ready(() => {
  $('.links').on('click', '.read', (e) => {
    e.preventDefault();
    let linkDiv = $(e.target.parentElement.parentElement);
    let readStatus = linkDiv.find('.read-status');
    let id = readStatus.data("id");
    let target = e.target;
    // debugger
    // debugger
    // let id = readStatus.data("id");
    // let a = document.createElement('a');
    // let linkText = document.createTextNode("Mark as Unread");
    // a.appendChild(linkText);
    // a.href = "#";
    $.ajax({
      type: "PUT",
      url: `/api/v1/links/${id}`,
      data: {link: {read: false}},
      success: () => {
        // debugger
        readStatus.text('Read: false');
        // linkDiv.className = `read-link link-${id}`;
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
        // debugger
        readStatus.text('Read: true');
        // linkDiv.className = `read-link link-${id}`;
        linkDiv[0].style.color = "grey";
        target.innerHTML="Mark as Unread";
        target.parentElement.className = "read";
      }
    });
  });
});
