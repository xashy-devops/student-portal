package com.xashytech.university.controller;

import com.xashytech.university.model.Student;
import com.xashytech.university.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Student Portal Controller
 * Handles web requests for student management
 */
@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    /**
     * Display student dashboard
     */
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        List<Student> students = studentService.getAllStudents();
        model.addAttribute("students", students);
        model.addAttribute("totalStudents", students.size());
        return "dashboard";
    }

    /**
     * Display all students
     */
    @GetMapping("/list")
    public String listStudents(Model model) {
        List<Student> students = studentService.getAllStudents();
        model.addAttribute("students", students);
        return "student-list";
    }

    /**
     * Show form to add new student
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("student", new Student());
        return "add-student";
    }

    /**
     * Process student registration
     */
    @PostMapping("/add")
    public String addStudent(@ModelAttribute Student student, Model model) {
        try {
            studentService.saveStudent(student);
            model.addAttribute("success", "Student registered successfully!");
            return "redirect:/students/list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to register student: " + e.getMessage());
            return "add-student";
        }
    }

    /**
     * Show student details
     */
    @GetMapping("/{id}")
    public String viewStudent(@PathVariable Long id, Model model) {
        Student student = studentService.getStudentById(id);
        if (student != null) {
            model.addAttribute("student", student);
            return "student-details";
        } else {
            model.addAttribute("error", "Student not found");
            return "redirect:/students/list";
        }
    }

    /**
     * Show form to edit student
     */
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Student student = studentService.getStudentById(id);
        if (student != null) {
            model.addAttribute("student", student);
            return "edit-student";
        } else {
            return "redirect:/students/list";
        }
    }

    /**
     * Process student update
     */
    @PostMapping("/{id}/edit")
    public String updateStudent(@PathVariable Long id, @ModelAttribute Student student, Model model) {
        try {
            student.setId(id);
            studentService.updateStudent(student);
            model.addAttribute("success", "Student updated successfully!");
            return "redirect:/students/" + id;
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update student: " + e.getMessage());
            return "edit-student";
        }
    }

    /**
     * Delete student
     */
    @PostMapping("/{id}/delete")
    public String deleteStudent(@PathVariable Long id, Model model) {
        try {
            studentService.deleteStudent(id);
            model.addAttribute("success", "Student deleted successfully!");
            return "redirect:/students/list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to delete student: " + e.getMessage());
            return "redirect:/students/list";
        }
    }

    /**
     * REST API endpoint - Get all students as JSON
     */
    @GetMapping("/api/students")
    @ResponseBody
    public List<Student> getStudentsAPI() {
        return studentService.getAllStudents();
    }

    /**
     * REST API endpoint - Get student by ID as JSON
     */
    @GetMapping("/api/students/{id}")
    @ResponseBody
    public Student getStudentAPI(@PathVariable Long id) {
        return studentService.getStudentById(id);
    }

    /**
     * Health check endpoint
     */
    @GetMapping("/health")
    @ResponseBody
    public String healthCheck() {
        return "Student Portal is running! Active students: " + studentService.getAllStudents().size();
    }
}