<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h2><i class="fa fa-lock"></i> Đổi mật khẩu</h2>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="row">
            <div class="col-md-6 col-sm-8 col-xs-12 col-md-offset-3">
                <div class="x_panel">
                    <div class="x_title">
                        <h2><i class="fa fa-key"></i> Cập nhật mật khẩu đăng nhập</h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <c:if test="${not empty msgSuccess}">
                            <div class="alert alert-success"><i class="fa fa-check-circle"></i> ${msgSuccess}</div>
                        </c:if>
                        <c:if test="${not empty msgError}">
                            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ${msgError}</div>
                        </c:if>

                        <form id="changePasswordForm" action="<c:url value='/change-password'/>" method="POST" class="form-horizontal form-label-left">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-12">Mật khẩu hiện tại <span class="required">*</span></label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                        <input type="text" name="oldPassword" id="oldPassword" class="form-control" required />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-12">Mật khẩu mới <span class="required">*</span></label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                        <input type="text" name="newPassword" id="newPassword" class="form-control" required minlength="6" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-12">Xác nhận mật khẩu <span class="required">*</span></label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                        <input type="text" name="confirmPassword" id="confirmPassword" class="form-control" required minlength="6" />
                                    </div>
                                    <span id="matchLabel" class="help-block"></span>
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-7 col-sm-7 col-xs-12 col-md-offset-4">
                                    <button type="button" class="btn btn-primary" onclick="history.back()"><i class="fa fa-arrow-left"></i> Huỷ</button>
                                    <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Lưu</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {

        function checkMatch() {
            var newPass = $('#newPassword').val();
            var confirmPass = $('#confirmPassword').val();
            var label = $('#matchLabel');

            if (confirmPass.length === 0) {
                label.text('');
                return;
            }
            if (newPass === confirmPass) {
                label.css('color', '#26A69A').html('<i class="fa fa-check"></i> Mật khẩu khớp');
            } else {
                label.css('color', '#EF5350').html('<i class="fa fa-times"></i> Mật khẩu không khớp');
            }
        }

        $('#confirmPassword').on('input', checkMatch);

        $('#changePasswordForm').on('submit', function(e) {
            var newPass = $('#newPassword').val();
            var confirmPass = $('#confirmPassword').val();
            if (newPass !== confirmPass) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
            }
        });
    });
</script>
