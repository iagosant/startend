class Shift < ActiveRecord::Base
  validates_uniqueness_of :datetime, scope: [:guard_id]
  belongs_to :site
  belongs_to :schedule
  belongs_to :guard

  def self.to_csv
    att_site = %w{ site datetime guard_id  }
    att_guard = %w{ first_name last_name }
    CSV.generate( headers: true ) do |csv|
      csv << att_site


      all.each do |shift|
        csv = shift.attributes.values_at(*att_site)
        csv = shift.attributes.values_at(*att_guard)
byebug
        site = shift.site.attributes.values_at("codename")
        first_name = shift.guard.attributes.values_at("first_name")
        last_name = shift.guard.attributes.values_at("first_name")

        shift_attributes[0] = site
        shift_attributes[3] = first_name
        shift_attributes[4] = last_name
        csv = shift_attributes
        byebug

      end
    end
  end

  def self.import(file)

    csv_path = file.path

    csv_text = File.read(csv_path)

    csv = CSV.parse(csv_text)

    sorted_csv = csv.sort

    sorted_csv.pop

    sorted_csv.each do |row|

      separated = row[0].split(";")

      site_name = separated.first

      short = site_name.gsub(/(\w)\w+\W*/, '\1').upcase

      Site.create(name: site_name, codename: short)

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
  end
end
