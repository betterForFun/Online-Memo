package com.example.Online.Memo.HelloController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class helloController {
	
	@RequestMapping("hello")
	public String helloJSP() {
		return "sayHello";
	}

}
