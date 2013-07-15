require 'csv'

def vote_meaning(number)
    case number.to_i
    when -9; 'absent'
    when 1; 'tellaye'
    when 2; 'aye'
    when 3; 'both'
    when 4; 'no'
    when 5; 'tellno'
    end
end

def convert(dat_file, txt_file)
    data = CSV.read(dat_file, :col_sep => "\t", :headers => true).reject(&:empty?)
    mp_info = []
    start = false
    CSV.foreach(dat_file, :col_sep => "\t") do |row|
        if row[0] =~ /^mpid/
            start = true 
            next
        end
        next unless start
        mp_info << row
    end
    mp_info.reject!(&:empty?)

    all_votes = []
    all_votes << [:date, :voteno, :bill, :vote, :mpid, :first_name, :surname, :party, :url]
    data[0..20].each do |vote|
        mp_info.each do |mpid, first_name, surname, party, url|
            all_votes << [  vote['date'],
                            vote['voteno'],
                            vote['Bill'],
                            vote_meaning(vote["mpid#{mpid}"]),
                            mpid,
                            first_name,
                            surname,
                            party,
                            url]
        end
    end

    CSV.open('vote_data.csv', 'wb') do |csv|
        all_votes.each do |l|
            csv << l
        end
    end

end
