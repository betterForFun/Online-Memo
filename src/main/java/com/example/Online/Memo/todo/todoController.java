package com.example.Online.Memo.todo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.validation.Valid;

@Controller
@SessionAttributes("name")
public class todoController {
	@Autowired
	private todoRepository todoRepository;
	
	@RequestMapping("todos")
	public String listAllTodots(ModelMap model) {
		String userName = (String)model.get("name");
		List<Todo> todos = todoRepository.findByusername(userName);
		model.addAttribute("todos", todos);
		return "todos";
	}
	
	@RequestMapping(value = "add-todo", method = RequestMethod.GET)
	public String showAddPage(ModelMap model){
		String username = (String)model.get("name");
		Todo todo = new Todo(0, username, "", LocalDate.now().plusYears(1), false);
		model.put("todo", todo);
		return "add-todo";
	}
	
	@RequestMapping(value = "add-todo", method = RequestMethod.POST)
	public String addtodo(ModelMap model, @Valid Todo todo, BindingResult result){
		if(result.hasErrors()) {
			return "add-todo";
		}
		String username = (String)model.get("name");
		todo.setUsername(username);
		todoRepository.save(todo);
		return "redirect:todos";
	}
	
	@RequestMapping("delete-todo")
	public String deleteTodo(@RequestParam int id) {
		todoRepository.deleteById(id);
		return "redirect:todos";
	}
	
	@RequestMapping(value = "update-todo", method = RequestMethod.GET)
	public String showUpdatePage(@RequestParam int id, ModelMap model){
		Todo todo = todoRepository.findById(id).get();
		model.addAttribute("todo", todo);
		return "update-todo";
	}
	
	@RequestMapping(value = "update-todo", method = RequestMethod.POST)
	public String updatetodo(ModelMap model, @Valid Todo todo, BindingResult result){
		if(result.hasErrors()) {
			return "update-todo";
		}
		todo.setUsername((String)model.get("name"));
		todoRepository.save(todo);
		return "redirect:todos";
	}
	
}
