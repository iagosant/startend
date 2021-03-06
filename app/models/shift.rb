class Shift < ActiveRecord::Base
  validates_uniqueness_of :datetime, scope: [:guard_id, :on_shift]
  belongs_to :site
  belongs_to :schedule
  belongs_to :guard

  def self.to_csv
    att_site = %w{ name shift datetime first_name last_name }

    CSV.generate( headers: true ) do |csv|
      csv << att_site

      all.each do |shift|

        shift_info = shift.attributes.values_at(*att_site)
        site = shift.site.codename
        shift_info[0] = site

        in_out = shift.on_shift

        if
          in_out == true
          shift_info[1] = "Start"
        else
          shift_info[1] = "End"
        end

        f_name = shift.guard.first_name
        l_name = shift.guard.last_name

        shift_info[3] = f_name
        shift_info[4] = l_name

        csv << shift_info

      end
    end
  end

  def self.import(file)
    csv_path = file.path

    csv_text = File.read(csv_path)

    csv = CSV.parse(csv_text)

    csv.shift

    csv.each do |row|


      separated = row[0].split(";")

      site_name = separated.first

      short = site_name.gsub(/(\w)\w+\W*/, '\1').upcase

      Site.create(name: site_name, codename: short)

      sup_device = ['353756072585664', '353756074063306']
      device_number = separated.last.split(" ").last
      if sup_device.include?(device_number)
        role = 'supervisor'
      else
        role = 'guard'
      end

      clean_name = separated[3]
      full_name = clean_name.to_s.downcase.split.map(&:capitalize).join(' ')
      last_name = full_name.split.first
      first_name = full_name.split.last

      Guard.create(first_name: first_name, last_name: last_name, role: role)

      date = separated[1]
      time = separated[2]
      dt = "#{date} #{time}"

      datetime = DateTime.strptime(dt, '%m/%d/%Y %H:%M %p')

      on_shift = separated[5].split(":")[0]
      shift_check = on_shift.split(" ")[1].downcase
      shift_check == "assigned" ? on_off = true : on_off = false

      Shift.create(guard_id: Guard.find_by(first_name: first_name).id,
      site_id: Site.find_by(name: site_name).id,
      datetime: datetime, on_shift: on_off)

    end

  end
end
