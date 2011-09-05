$.extend(hatch, {
  ajaxError  : function(xhr, status, error) {
    if (xhr.status === 403) {
      templateAapp.redirectToLogin();
    }
  }
});
