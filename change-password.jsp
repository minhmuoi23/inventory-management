<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
  .cp-wrapper {
    min-height: calc(100vh - 120px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 16px;
  }

  .cp-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 24px rgba(30, 77, 140, 0.10), 0 1px 4px rgba(0,0,0,0.06);
    width: 100%;
    max-width: 460px;
    overflow: hidden;
  }

  .cp-card-header {
    background: linear-gradient(135deg, #1a3a5c 0%, #1e4d8c 100%);
    padding: 32px 36px 28px;
    text-align: center;
  }

  .cp-card-header .cp-icon {
    width: 56px;
    height: 56px;
    background: rgba(255,255,255,0.15);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 14px;
  }

  .cp-card-header .cp-icon i {
    font-size: 24px;
    color: #fff;
  }

  .cp-card-header h3 {
    color: #fff;
    font-size: 20px;
    font-weight: 600;
    margin: 0 0 4px;
  }

  .cp-card-header p {
    color: rgba(255,255,255,0.72);
    font-size: 13px;
    margin: 0;
  }

  .cp-card-body {
    padding: 32px 36px 28px;
  }

  .cp-alert {
    border-radius: 8px;
    padding: 12px 16px;
    margin-bottom: 24px;
    font-size: 13.5px;
    display: flex;
    align-items: center;
    gap: 10px;
    border: none;
  }

  .cp-alert-success {
    background: #e8f5e9;
    color: #2e7d32;
    border-left: 4px solid #43a047;
  }

  .cp-alert-error {
    background: #fdecea;
    color: #c62828;
    border-left: 4px solid #e53935;
  }

  .cp-field {
    margin-bottom: 20px;
  }

  .cp-field label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #37474f;
    margin-bottom: 7px;
    letter-spacing: 0.2px;
  }

  .cp-field label .required {
    color: #e53935;
    margin-left: 2px;
  }

  .cp-input-wrap {
    position: relative;
  }

  .cp-input-wrap .field-icon {
    position: absolute;
    left: 13px;
    top: 50%;
    transform: translateY(-50%);
    color: #90a4ae;
    font-size: 14px;
    pointer-events: none;
  }

  .cp-input-wrap input {
    width: 100%;
    padding: 10px 42px 10px 38px;
    border: 1.5px solid #cfd8dc;
    border-radius: 8px;
    font-size: 14px;
    color: #263238;
    background: #f8fafc;
    transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
    outline: none;
    box-sizing: border-box;
  }

  .cp-input-wrap input:focus {
    border-color: #1e4d8c;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(30, 77, 140, 0.10);
  }

  .cp-input-wrap .toggle-pw {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: #90a4ae;
    cursor: pointer;
    font-size: 14px;
    transition: color 0.15s;
    background: none;
    border: none;
    padding: 0;
  }

  .cp-input-wrap .toggle-pw:hover {
    color: #1e4d8c;
  }

  .cp-hint {
    font-size: 11.5px;
    color: #90a4ae;
    margin-top: 5px;
  }

  .cp-strength {
    height: 4px;
    border-radius: 2px;
    background: #eceff1;
    margin-top: 8px;
    overflow: hidden;
  }

  .cp-strength-bar {
    height: 100%;
    border-radius: 2px;
    transition: width 0.3s, background 0.3s;
    width: 0;
  }

  .cp-divider {
    border: none;
    border-top: 1px solid #eceff1;
    margin: 24px 0 20px;
  }

  .cp-actions {
    display: flex;
    gap: 12px;
  }

  .cp-btn {
    flex: 1;
    padding: 11px 0;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    transition: all 0.18s;
    letter-spacing: 0.2px;
  }

  .cp-btn-cancel {
    background: #eceff1;
    color: #546e7a;
  }

  .cp-btn-cancel:hover {
    background: #cfd8dc;
    color: #263238;
  }

  .cp-btn-submit {
    background: linear-gradient(135deg, #1565c0, #1e4d8c);
    color: #fff;
    box-shadow: 0 2px 8px rgba(30, 77, 140, 0.25);
  }

  .cp-btn-submit:hover {
    background: linear-gradient(135deg, #0d47a1, #1a3a5c);
    box-shadow: 0 4px 12px rgba(30, 77, 140, 0.35);
    transform: translateY(-1px);
  }

  .cp-btn-submit:active {
    transform: translateY(0);
  }

  /* Match indicator */
  .cp-match {
    font-size: 11.5px;
    margin-top: 5px;
    display: none;
  }
  .cp-match.ok { color: #43a047; display: block; }
  .cp-match.fail { color: #e53935; display: block; }
</style>

<div class="right_col" role="main">
  <div class="cp-wrapper">
    <div class="cp-card">

      <div class="cp-card-header">
        <div class="cp-icon"><i class="fa fa-lock"></i></div>
        <h3>Đổi mật khẩu</h3>
        <p>Cập nhật mật khẩu để bảo vệ tài khoản của bạn</p>
      </div>

      <div class="cp-card-body">

        <c:if test="${not empty msgSuccess}">
          <div class="cp-alert cp-alert-success">
            <i class="fa fa-check-circle"></i>
            <span>${msgSuccess}</span>
          </div>
        </c:if>
        <c:if test="${not empty msgError}">
          <div class="cp-alert cp-alert-error">
            <i class="fa fa-exclamation-circle"></i>
            <span>${msgError}</span>
          </div>
        </c:if>

        <form action="<c:url value='/change-password'/>" method="POST" id="cpForm" novalidate>

          <div class="cp-field">
            <label>Mật khẩu hiện tại <span class="required">*</span></label>
            <div class="cp-input-wrap">
              <i class="fa fa-key field-icon"></i>
              <input type="password" name="oldPassword" id="oldPassword" placeholder="Nhập mật khẩu hiện tại" required />
              <button type="button" class="toggle-pw" data-target="oldPassword" tabindex="-1">
                <i class="fa fa-eye"></i>
              </button>
            </div>
          </div>

          <div class="cp-field">
            <label>Mật khẩu mới <span class="required">*</span></label>
            <div class="cp-input-wrap">
              <i class="fa fa-lock field-icon"></i>
              <input type="password" name="newPassword" id="newPassword" placeholder="Tối thiểu 6 ký tự" required minlength="6" />
              <button type="button" class="toggle-pw" data-target="newPassword" tabindex="-1">
                <i class="fa fa-eye"></i>
              </button>
            </div>
            <div class="cp-strength"><div class="cp-strength-bar" id="strengthBar"></div></div>
            <div class="cp-hint" id="strengthLabel">Độ mạnh mật khẩu</div>
          </div>

          <div class="cp-field">
            <label>Xác nhận mật khẩu mới <span class="required">*</span></label>
            <div class="cp-input-wrap">
              <i class="fa fa-check-circle field-icon"></i>
              <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu mới" required minlength="6" />
              <button type="button" class="toggle-pw" data-target="confirmPassword" tabindex="-1">
                <i class="fa fa-eye"></i>
              </button>
            </div>
            <div class="cp-match" id="matchMsg"></div>
          </div>

          <hr class="cp-divider">

          <div class="cp-actions">
            <button type="button" class="cp-btn cp-btn-cancel" onclick="history.back()">
              <i class="fa fa-arrow-left"></i> Huỷ
            </button>
            <button type="submit" class="cp-btn cp-btn-submit">
              <i class="fa fa-save"></i> Lưu thay đổi
            </button>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function () {

  // Toggle show/hide password
  $('.toggle-pw').on('click', function () {
    var targetId = $(this).data('target');
    var input = $('#' + targetId);
    var icon = $(this).find('i');
    if (input.attr('type') === 'password') {
      input.attr('type', 'text');
      icon.removeClass('fa-eye').addClass('fa-eye-slash');
    } else {
      input.attr('type', 'password');
      icon.removeClass('fa-eye-slash').addClass('fa-eye');
    }
  });

  // Password strength indicator
  $('#newPassword').on('input', function () {
    var val = $(this).val();
    var score = 0;
    if (val.length >= 6) score++;
    if (val.length >= 10) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    var bar = $('#strengthBar');
    var label = $('#strengthLabel');

    if (val.length === 0) {
      bar.css({ width: '0', background: '' });
      label.text('Độ mạnh mật khẩu').css('color', '#90a4ae');
    } else if (score <= 1) {
      bar.css({ width: '25%', background: '#e53935' });
      label.text('Yếu').css('color', '#e53935');
    } else if (score === 2) {
      bar.css({ width: '50%', background: '#fb8c00' });
      label.text('Trung bình').css('color', '#fb8c00');
    } else if (score === 3) {
      bar.css({ width: '75%', background: '#43a047' });
      label.text('Khá mạnh').css('color', '#43a047');
    } else {
      bar.css({ width: '100%', background: '#1e88e5' });
      label.text('Rất mạnh').css('color', '#1e88e5');
    }

    checkMatch();
  });

  // Password match indicator
  $('#confirmPassword').on('input', checkMatch);

  function checkMatch() {
    var np = $('#newPassword').val();
    var cp = $('#confirmPassword').val();
    var msg = $('#matchMsg');
    if (cp.length === 0) {
      msg.removeClass('ok fail').hide();
      return;
    }
    if (np === cp) {
      msg.removeClass('fail').addClass('ok').text('✓ Mật khẩu khớp').show();
    } else {
      msg.removeClass('ok').addClass('fail').text('✗ Mật khẩu không khớp').show();
    }
  }

  // Form submit validation
  $('#cpForm').on('submit', function (e) {
    var newPass = $('#newPassword').val();
    var confirmPass = $('#confirmPassword').val();
    if (newPass !== confirmPass) {
      e.preventDefault();
      $('#matchMsg').removeClass('ok').addClass('fail').text('✗ Mật khẩu xác nhận không khớp!').show();
      $('#confirmPassword').focus();
    }
  });

});
</script>
