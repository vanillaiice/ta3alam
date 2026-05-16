require "faker"

PARAGRAPH = Faker::Lorem.paragraph

def new_fake_text_file(name)
  text = Faker::Lorem.paragraphs(number: 3).join("\n\n")
  {
    io: StringIO.new(text),
    filename: "#{name}-#{SecureRandom.hex(4)}.txt",
    content_type: "text/plain"
  }
end

puts "clearing old data..."
Course.destroy_all
User.destroy_all

puts "creating new data..."

owners = 5.times.map do |i|
  User.create!(
    {
      role: :owner,
      name: Faker::Name.name,
      email_address: "owner#{i}@email.com",
      password: "password",
      password_confirmation: "password"
    }
  )
end

courses = 5.times.map do |i|
  courseName = Faker::Educator.unique.course_name
  name, number = courseName.rpartition(" ").values_at(0, 2)
  number = number.to_i

  Course.create!(
    {
      name: name,
      number: number,
      description: PARAGRAPH,
      created_at: Time.current,
      updated_at: Time.current
    }
  )
end

courses.each_with_index do |course, i|
  klasses = 3.times.map do
    {
      code: Faker::Name.initials,
      course_id: course.id
    }
  end
  Klass.insert_all!(klasses)

  Klass.where(course_id: course.id).each_with_index do |klass, j|
    teachers = rand(2..5).times.map do |k|
      User.create!(
        {
          role: :teacher,
          name: Faker::Name.name,
          email_address: "teacher#{i}#{j}#{k}@email.com",
          password: "password",
          password_confirmation: "password"
        }
      )
    end
    teachers.each do |teacher|
      Teacher.create!(
        klass: klass,
        user: teacher
      )

      Announcement.create!(
        klass: klass,
        user: teacher,
        content: PARAGRAPH
      )
    end

    students = rand(5..10).times.map do |k|
      User.create!(
        role: :student,
        name: Faker::Name.name,
        email_address: "student#{i}#{j}#{k}@email.com",
        password: "password",
        password_confirmation: "password",
      )
    end
    students.each do |student|
      Student.create!(
        klass: klass,
        user: student
      )
    end

    modules = [
      "Introduction",
      "Basics",
      "Advanced"
    ]
    modules.each do |mod|
      content = Content.new(
        klass: klass,
        user: teachers.sample,
        module_name: mod,
        title: mod,
        description: PARAGRAPH
      )
      f = new_fake_text_file(mod.parameterize)
      content.file.attach(f)
      content.save!

      assignment_names = [
        "Summary",
        "Exercises",
        "Final Project"
      ]
      assignment_names.each do |assignment_name|
        assignment = Assignment.create!(
          klass: klass,
          user: teachers.sample,
          title: assignment_name,
          description: PARAGRAPH,
          deadline: Time.current + 1.week
        )
        f = new_fake_text_file(assignment_name)
        assignment.file.attach(f)

        students.sample(5).each do |student|
          submission = Submission.create!(
            assignment: assignment,
            user: student
          )
          f = new_fake_text_file("submission-#{student.name}")
          submission.submission_file.attach(f)
        end
      end
    end
  end
end

puts "done!"
