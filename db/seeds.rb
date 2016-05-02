require 'csv'
require 'date'

# data_year = 2012
# department_data = []
# job_data = []
# employee_data = []
# gender = GenderDetector.new
# while data_year <= 2016
  csv_text = File.open(Rails.root.join('lib', 'seeds', 'export.csv'))
  csv = CSV.parse(csv_text) #, :headers => true)
  #  Site;Date/Time;Date/Time;Device User;Activity;Addl. Information

    pre_sorted_csv = csv.sort[0]

    sorted_csv = csv.sort

    sorted_csv.pop

    @all_sites = []
    @all_users = []
    @all_schedules = []
    @all_shifts = []

    sorted_csv.each do |row|

    separated = row[0].split(";")

    @shift = []

    site_name = separated.first
    @shift << site_name

    Site.all.each do |site|
      @all_sites << site.name
    end

    format_name = separated.last.split(":")[1].to_s.strip!
    full_name = format_name.to_s.downcase.split.map(&:capitalize).join(' ')
    @last_name = full_name.split.first
    @first_name = full_name.split.last
    guard_name = "#{@first_name} #{@last_name}"

    if @all_users.exclude?(guard_name)
    @all_users << guard_name
    end

    @shift << guard_name

    startend = separated.last.split(":")[0]
    if startend.split[0] == "Start"
      shift = "STARTED shift"
    elsif startend.split[0] == "End"
      shift = "ENDED shift"
    end
    @shift << startend

    date = separated[1]
    date.split("/")[1]
    date = DateTime.strptime(date, "%m/%d/%Y")
    @shift << date

    time = separated[2]
    @shift << time

    on_shift = separated[5].split(":")[0]
    on_off = on_shift.split(" ")[0].downcase
    if on_off == "start"
      @on_off = true
    else
      @on_off = false
    end

    @all_shifts << @shift

    if @all_sites.exclude?(site_name)
      Site.create(name: site_name)
    end

    if User.first == nil
      @new_user = User.create(first_name: @first_name, last_name: @last_name)
    end

    @all_users.each do |name|
      n = name.split(" ")
        if User.find_by(first_name: n[0], last_name: n[1]) == nil
          @new_user = User.create(first_name: n[0], last_name: n[1])
        end
    end

    Schedule.create(date: date)

    Shift.create(user_id: User.find_by(first_name: @first_name).id,
                 site_id: Site.find_by(name: site_name).id,
                 schedule_id: Schedule.find_by(date: date).id,
                 on_shift: @on_off)

  end


  #
  # Employee => name, location, start_shift, end_shift
  # puts "processing department and job title data....."
  # csv1.each do |row|
  #   department = row["DEPARTMENT"].split.map(&:capitalize).join(" ")
  #   unless department_data.include?(department)
  #     Department.create(name: department)
  #     department_data << department
  #   end
  #
  #   title = row["TITLE"].split.map(&:capitalize).join(" ")
  #   unless job_data.include?(title)
  #     JobTitle.create(title: title,
  #                     department_id: Department.find_by(name: department).id)
  #     job_data << title
  #   end
  # end
  #
  # def gender_guesser
  #   with_probability(0.514) do
  #     return :female
  #   end
  #   return :male
  # end
  #
  # csv_text2 = File.read("#{data_year}-salaries.csv")
  # csv2 = CSV.parse(csv_text2, :headers => true)
  #   puts "processing employee data....."
  # csv2.each do |row|
  #   name = row[0].split(',')[1].strip.split(' ')[0].capitalize
  #   name_gender = gender.get_gender(name, :usa)
  #   if name_gender == :mostly_female
  #     name_gender = :female
  #   elsif name_gender == :mostly_male
  #     name_gender = :male
  #   elsif name_gender == :andy
  #     name_gender = gender_guesser
  #   end
  #
  #   if data_year == 2016
  #     salary = (row["YTD GROSS"].gsub(/[$,]/,'').strip.to_f * BigDecimal(4))
  #   else
  #     salary = row['YTD GROSS'].gsub(/[$,]/,'').strip.to_f
  #   end
  #   row_name = row["NAME"]
  #   department = row["DEPARTMENT"].split.map(&:capitalize).join(" ")
  #   title = row["TITLE"].split.map(&:capitalize).join(" ")
  #   unless employee_data.include?(row_name)
  #     Employee.create(name: row_name, salary: salary,
  #                     gender: name_gender, data_year: data_year,
  #                     department_id: Department.find_by(name: department).id,
  #                     job_title_id: JobTitle.find_by(title: title).id)
  #     employee_data << row_name
  #   end
  # end
  # employee_data = []
  # data_year += 1
# end
