class VoteTable
    attr_accessor :vote_rows, :bill_table, :mp_table
    def initialize
        @vote_rows = []
        @bill_table = BillTable.new
        @mp_table = MPTable.new
    end
    def from_single_data_file(file='vote_data.csv')
        @vote_rows = []
        CSV.foreach(file, :headers => true) do |r|
            mp = @mp_table.find_or_create(r)
            bill = @bill_table.find_or_create(r)
            @vote_rows << Vote.new(mp, bill, r['vote'])
        end
    end
    def from_separate_data_files(votes='votes.csv', mps='mps.csv', mp_votes='mp_votes.csv')

    end

end

class MPTable
    def initialize
        @mp_rows = {}
    end
    def find_or_create(row)
        mpid = row['mpid'].to_i
        # if we don't have an mp with that id, create one
        if @mp_rows[mpid].nil?
            @mp_rows[mpid] = MPRow.new(row)
        end
        # return the mp
        return @mp_rows[mpid]
    end
end

class BillTable
    # fill in this to work like MP table
end

class VoteRow
    def initialize(mp_row, bill_row, vote)
        @mp_row = mp_row
        @bill_row = bill_row
        @vote = vote
    end
end

class MPRow
    attr_accessor :mpid, :first_name, :surname, :party, :url
    def initialize(row)
        @mpid = row['mpid'].to_i
        @first_name = row['first_name']
        @surname = row['surname']
        @party = row['party']
        @url = row['url']
    end
end

class BillRow
    # fill in this to work like MPRow
end