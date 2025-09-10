package com.xashytech.university.service;

import com.xashytech.university.dao.StudentDAO;
import com.xashytech.university.model.Student;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Unit tests for StudentService
 * Demonstrates testing practices for DevOps pipeline
 */
@RunWith(MockitoJUnitRunner.class)
public class StudentServiceTest {

    @Mock
    private StudentDAO studentDAO;

    @InjectMocks
    private StudentService studentService;

    private Student testStudent;
    private List<Student> testStudents;

    @Before
    public void setUp() {
        testStudent = new Student();
        testStudent.setId(1L);
        testStudent.setStudentId("XTU20250001");
        testStudent.setFirstName("John");
        testStudent.setLastName("Doe");
        testStudent.setEmail("john.doe@xashytech.edu");
        testStudent.setProgram("Computer Science");
        testStudent.setYear("2");
        testStudent.setStatus("ACTIVE");
        testStudent.setEnrollmentDate(LocalDate.now());
        testStudent.setGpa(3.75);

        Student testStudent2 = new Student();
        testStudent2.setId(2L);
        testStudent2.setStudentId("XTU20250002");
        testStudent2.setFirstName("Jane");
        testStudent2.setLastName("Smith");
        testStudent2.setEmail("jane.smith@xashytech.edu");
        testStudent2.setProgram("Software Engineering");
        testStudent2.setYear("3");
        testStudent2.setStatus("ACTIVE");
        testStudent2.setEnrollmentDate(LocalDate.now());
        testStudent2.setGpa(3.92);

        testStudents = Arrays.asList(testStudent, testStudent2);
    }

    @Test
    public void testGetAllStudents() {
        // Arrange
        when(studentDAO.findAll()).thenReturn(testStudents);

        // Act
        List<Student> result = studentService.getAllStudents();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("John", result.get(0).getFirstName());
        assertEquals("Jane", result.get(1).getFirstName());
        verify(studentDAO, times(1)).findAll();
    }

    @Test
    public void testGetStudentById() {
        // Arrange
        when(studentDAO.findById(1L)).thenReturn(testStudent);

        // Act
        Student result = studentService.getStudentById(1L);

        // Assert
        assertNotNull(result);
        assertEquals("John", result.getFirstName());
        assertEquals("XTU20250001", result.getStudentId());
        verify(studentDAO, times(1)).findById(1L);
    }

    @Test
    public void testSaveStudent_Success() {
        // Arrange
        Student newStudent = new Student();
        newStudent.setStudentId("XTU20250003");
        newStudent.setFirstName("Mike");
        newStudent.setLastName("Johnson");
        newStudent.setEmail("mike.johnson@xashytech.edu");
        newStudent.setProgram("Cybersecurity");
        newStudent.setYear("1");

        when(studentDAO.findByStudentId(anyString())).thenReturn(null);
        when(studentDAO.findByEmail(anyString())).thenReturn(null);
        when(studentDAO.save(any(Student.class))).thenReturn(newStudent);

        // Act
        Student result = studentService.saveStudent(newStudent);

        // Assert
        assertNotNull(result);
        assertEquals("Mike", result.getFirstName());
        verify(studentDAO, times(1)).save(newStudent);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testSaveStudent_DuplicateStudentId() {
        // Arrange
        Student newStudent = new Student();
        newStudent.setStudentId("XTU20250001"); // Duplicate ID
        newStudent.setFirstName("Mike");
        newStudent.setLastName("Johnson");
        newStudent.setEmail("mike.johnson@xashytech.edu");
        newStudent.setProgram("Cybersecurity");
        newStudent.setYear("1");

        when(studentDAO.findByStudentId("XTU20250001")).thenReturn(testStudent);

        // Act
        studentService.saveStudent(newStudent);

        // Assert - Exception should be thrown
    }

    @Test(expected = IllegalArgumentException.class)
    public void testSaveStudent_DuplicateEmail() {
        // Arrange
        Student newStudent = new Student();
        newStudent.setStudentId("XTU20250003");
        newStudent.setFirstName("Mike");
        newStudent.setLastName("Johnson");
        newStudent.setEmail("john.doe@xashytech.edu"); // Duplicate email
        newStudent.setProgram("Cybersecurity");
        newStudent.setYear("1");

        when(studentDAO.findByStudentId(anyString())).thenReturn(null);
        when(studentDAO.findByEmail("john.doe@xashytech.edu")).thenReturn(testStudent);

        // Act
        studentService.saveStudent(newStudent);

        // Assert - Exception should be thrown
    }

    @Test
    public void testUpdateStudent_Success() {
        // Arrange
        Student updatedStudent = new Student();
        updatedStudent.setId(1L);
        updatedStudent.setStudentId("XTU20250001");
        updatedStudent.setFirstName("John");
        updatedStudent.setLastName("Doe");
        updatedStudent.setEmail("john.doe.updated@xashytech.edu");
        updatedStudent.setProgram("Computer Science");
        updatedStudent.setYear("3");

        when(studentDAO.findById(1L)).thenReturn(testStudent);
        when(studentDAO.findByEmail("john.doe.updated@xashytech.edu")).thenReturn(null);
        when(studentDAO.update(any(Student.class))).thenReturn(updatedStudent);

        // Act
        Student result = studentService.updateStudent(updatedStudent);

        // Assert
        assertNotNull(result);
        assertEquals("john.doe.updated@xashytech.edu", result.getEmail());
        verify(studentDAO, times(1)).update(updatedStudent);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testUpdateStudent_NotFound() {
        // Arrange
        Student updatedStudent = new Student();
        updatedStudent.setId(999L);
        updatedStudent.setStudentId("XTU20250001");
        updatedStudent.setFirstName("John");
        updatedStudent.setLastName("Doe");
        updatedStudent.setEmail("john.doe@xashytech.edu");
        updatedStudent.setProgram("Computer Science");
        updatedStudent.setYear("3");

        when(studentDAO.findById(999L)).thenReturn(null);

        // Act
        studentService.updateStudent(updatedStudent);

        // Assert - Exception should be thrown
    }

    @Test
    public void testDeleteStudent_Success() {
        // Arrange
        when(studentDAO.findById(1L)).thenReturn(testStudent);
        when(studentDAO.delete(1L)).thenReturn(true);

        // Act
        boolean result = studentService.deleteStudent(1L);

        // Assert
        assertTrue(result);
        verify(studentDAO, times(1)).delete(1L);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testDeleteStudent_NotFound() {
        // Arrange
        when(studentDAO.findById(999L)).thenReturn(null);

        // Act
        studentService.deleteStudent(999L);

        // Assert - Exception should be thrown
    }

    @Test
    public void testSearchStudentsByName() {
        // Arrange
        when(studentDAO.findAll()).thenReturn(testStudents);

        // Act
        List<Student> result = studentService.searchStudentsByName("John");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
    }

    @Test
    public void testGetStudentsByProgram() {
        // Arrange
        when(studentDAO.findAll()).thenReturn(testStudents);

        // Act
        List<Student> result = studentService.getStudentsByProgram("Computer Science");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("Computer Science", result.get(0).getProgram());
    }

    @Test
    public void testGetActiveStudents() {
        // Arrange
        when(studentDAO.findAll()).thenReturn(testStudents);

        // Act
        List<Student> result = studentService.getActiveStudents();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size());
        assertTrue(result.stream().allMatch(Student::isActive));
    }

    @Test
    public void testGetStatistics() {
        // Arrange
        when(studentDAO.findAll()).thenReturn(testStudents);

        // Act
        StudentService.StudentStatistics stats = studentService.getStatistics();

        // Assert
        assertNotNull(stats);
        assertEquals(2, stats.getTotalStudents());
        assertEquals(2, stats.getActiveStudents());
        assertEquals(0, stats.getInactiveStudents());
        assertEquals(3.835, stats.getAverageGpa(), 0.01);
    }

    @Test
    public void testStudentValidation_Invalid() {
        // Arrange
        Student invalidStudent = new Student();
        // Missing required fields

        // Act & Assert
        try {
            studentService.saveStudent(invalidStudent);
            fail("Should have thrown IllegalArgumentException");
        } catch (IllegalArgumentException e) {
            assertEquals("Student data is invalid", e.getMessage());
        }
    }
}
