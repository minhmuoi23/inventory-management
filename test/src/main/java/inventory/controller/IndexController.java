package inventory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import inventory.service.DashboardService;

@Controller
public class IndexController {
    @Autowired
    private DashboardService dashboardService;

    @GetMapping({"/index", "/dashboard"})
    public String index(Model model) {
        model.addAttribute("dashboard", dashboardService.getDashboard());
        return "index";
    }
}
