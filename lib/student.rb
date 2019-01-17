class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name =  row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    sql = "SELECT * FROM students"
    DB[:conn].execute(sql).map {|row| self.new_from_db(row)}
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ? LIMIT 1"
    DB[:conn].execute(sql, name).map {|row| self.new_from_db(row)}.first
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.all_students_in_grade_9
    sql = "SELECT id, name, grade FROM students WHERE grade = ?"
    DB[:conn].execute(sql, 9).map {|row| self.new_from_db(row)}
  end

  def self.students_below_12th_grade
    sql = "SELECT id, name, grade FROM students WHERE grade <= ?"
    DB[:conn].execute(sql, 11).map {|row| self.new_from_db(row)}
  end

  def self.first_student_in_grade_10
    sql = "SELECT id, name, grade FROM students WHERE grade = ?"
    row = DB[:conn].execute(sql, 10).first
    self.new_from_db(row)
  end

  def self.all_students_in_grade_X(grade)
    sql = "SELECT id, name, grade FROM students WHERE grade = ?"
    DB[:conn].execute(sql, grade).map {|row| self.new_from_db(row)}
  end

  def self.first_X_students_in_grade_10(x)
    sql = "SELECT id, name, grade FROM students WHERE grade = 10 LIMIT ?"
    DB[:conn].execute(sql, x).map {|row| self.new_from_db(row)}
  end
end
