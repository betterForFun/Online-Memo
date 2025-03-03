package com.example.Online.Memo.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("name")
public class WelcomController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String goWelcomePage(ModelMap model) {
		model.put("name", getUserName());
		return "welcome";
	}
	
	private String getUserName() {
		org.springframework.security.core.Authentication temp = SecurityContextHolder.getContext().getAuthentication();
		return temp.getName();
	}
	
}