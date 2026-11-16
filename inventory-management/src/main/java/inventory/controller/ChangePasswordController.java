package inventory.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import inventory.model.Users;
import inventory.service.UserService;
import inventory.util.Constant;
import inventory.util.HashingPassword;

@Controller
public class ChangePasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/change-password")
    public String showChangePassword() {
        return "change-password";
    }

    @PostMapping("/change-password")
    public String processChangePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session,
            Model model) {

        Users userInfo = (Users) session.getAttribute(Constant.USER_INFO);
        if (userInfo == null) {
            return "redirect:/login";
        }

        // Kiểm tra mật khẩu hiện tại
        String hashedOld = HashingPassword.encrypt(oldPassword);
        if (!hashedOld.equals(userInfo.getPassword())) {
            model.addAttribute(Constant.MSG_ERROR, "Mật khẩu hiện tại không đúng!");
            return "change-password";
        }

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute(Constant.MSG_ERROR, "Mật khẩu xác nhận không khớp!");
            return "change-password";
        }

        if (newPassword.length() < 6) {
            model.addAttribute(Constant.MSG_ERROR, "Mật khẩu mới phải có ít nhất 6 ký tự!");
            return "change-password";
        }

        try {
            Users user = userService.findById(userInfo.getId());
            user.setPassword(HashingPassword.encrypt(newPassword));
            userService.updatePassword(user);

            // Cập nhật lại session
            userInfo.setPassword(HashingPassword.encrypt(newPassword));
            session.setAttribute(Constant.USER_INFO, userInfo);

            model.addAttribute(Constant.MSG_SUCCESS, "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            model.addAttribute(Constant.MSG_ERROR, "Đổi mật khẩu thất bại, vui lòng thử lại!");
        }

        return "change-password";
    }
}
