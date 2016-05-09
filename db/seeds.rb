require 'csv'
require 'date'

csv_text = File.read('export.csv')

csv = CSV.parse(csv_text)

sorted_csv = csv.sort
sorted_csv.pop

sorted_csv.each do |row|

  separated = row[0].split(";")

  site_name = separated.first

  Site.create(name: site_name)

  format_name = separated.last.split(":")[1].to_s.strip!
  full_name = format_name.to_s.downcase.split.map(&:capitalize).join(' ')
  last_name = full_name.split.first
  first_name = full_name.split.last

  Guard.create(first_name: first_name, last_name: last_name)

  date = separated[1]
  time = separated[2].split.first
  dt = "#{date} #{time}"
  datetime = DateTime.strptime(dt, '%m/%d/%Y %H:%M')

  on_shift = separated[5].split(":")[0]
  shift_check = on_shift.split(" ")[0].downcase
  shift_check == "start" ? on_off = true : on_off = false

  Shift.create(guard_id: Guard.find_by(first_name: first_name).id,
  site_id: Site.find_by(name: site_name).id,
  datetime: datetime, on_shift: on_off)

end
