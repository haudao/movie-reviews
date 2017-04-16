function validateForm(sign_up_form) {
  var username = sign_up_form["user[username]"].value;
  var email = sign_up_form["user[email]"].value;
  var pwd = sign_up_form["user[password]"].value;
  var pwd_confirm = sign_up_form["user[password_confirmation]"].value;
  var err_count = 0;

  clearOldError(sign_up_form);
  err_count = validateUsername(username);
  err_count += validateEmail(email);
  err_count += validatePassword(pwd, pwd_confirm);
  if (err_count != 0) {
    return false;
  }
  else {
    return true;
  }
}

function validateUsername(username) {
  var err_count = 0;
  var usr_elem = getParent('username');
  if (username == "") {
    showErrorMessage(usr_elem, 'user_msg', 'Vui lòng nhập tên người dùng.');
    err_count += 1;
  }
  else {
    if (username.length < 6) {
      showErrorMessage(usr_elem, 'user_msg', 'Tên người dùng phải có ít nhất 6 kí tự.');
      err_count += 1;
    }
    else {
      if (!/^[0-9a-zA-Z_.-]+$/.test(username)) {
        showErrorMessage(usr_elem, 'user_msg', 'Tên người dùng không hợp lệ.');
        err_count += 1;
      }
    }
  }
  return err_count;
}

function validateEmail(email) {
  var err_count = 0;
  var email_elem = getParent('email');
  if (email == "") {
    showErrorMessage(email_elem, 'email_msg', 'Vui lòng nhập email.');
    err_count += 1;
  }
  else {
    if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)) {
      showErrorMessage(email_elem, 'email_msg', 'Email không hợp lệ.');
      err_count += 1;
    }
  }
  return err_count;
}

function validatePassword(pwd, pwd_confirm) {
  var err_count = 0;
  var pwd_elem = getParent('pwd');
  if (pwd == "") {
    showErrorMessage(pwd_elem, 'pwd_msg', 'Vui lòng nhập mật khẩu.');
    err_count += 1;
  }
  else {
    if (pwd.length < 6) {
      showErrorMessage(pwd_elem, 'pwd_msg', 'Mật khẩu phải có ít nhất 6 kí tự.');
      err_count += 1;
    }
    else {
      var pwd_confirm_elem = getParent('pwd_confirm');
      if (pwd_confirm == "") {
        showErrorMessage(pwd_confirm_elem, 'pwd_confirm_msg', 'Vui lòng xác nhận mật khẩu.');
        err_count += 1;
      }
      else {
        if (pwd !== pwd_confirm) {
          showErrorMessage(pwd_confirm_elem, 'pwd_confirm_msg', 'Không khớp mật khẩu, vui lòng xác nhận lại.');
          err_count += 1;
        }
      }
    }
  }
  return err_count;
}

function showErrors(errs, pars) {
  document.getElementById('username').setAttribute('value', pars.user.username);
  document.getElementById('email').setAttribute('value', pars.user.email);
  document.getElementById('pwd').setAttribute('value', pars.user.password);
  document.getElementById('pwd_confirm').setAttribute('value', pars.user.password_confirmation);
  if (errs.username != undefined) {
    var usr_elem = getParent('username');
    for (i = 0; i < errs.username.length; i++) {
      showErrorMessage(usr_elem, 'user_msg', errs.username[i]);
    }
  }

  if (errs.email != undefined) {
    var email_elem = getParent('email');
    for (i = 0; i < errs.email.length; i++) {
      showErrorMessage(email_elem, 'email_msg', errs.email[i]);
    }
  }

  if (errs.password != undefined) {
    var pwd_elem = getParent('pwd');
    for (i = 0; i < errs.password.length; i++) {
      showErrorMessage(pwd_elem, 'pwd_msg', errs.password[i]);
    }
  }

  if (errs.password_confirmation != undefined) {
    var pwd_confirm_elem = getParent('pwd_confirm');
    showErrorMessage(pwd_confirm_elem, 'pwd_confirm_msg', errs.password_confirmation[0]);
  }

}

function getParent(name) {
  return document.getElementById(name).parentElement.parentElement.parentElement;
}

function showErrorMessage(elem, id, err) {
  var msg = document.createElement('span');
  msg.setAttribute('id', id);
  msg.setAttribute('class', 'help-block');
  msg.innerHTML = err;
  elem.setAttribute('class', 'form-group has-error');
  elem.appendChild(msg);
}

function clearOldError(form) {
  var err_fields = form.getElementsByClassName('form-group has-error');
  while (err_fields.length > 0) {
    var msg = err_fields[0].getElementsByClassName('help-block');
    while (msg.length > 0) {
      msg[0].parentElement.removeChild(msg[0]);
    }
    err_fields[0].setAttribute('class', 'form-group');
  }
}
