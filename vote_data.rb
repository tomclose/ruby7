require 'csv'
# Split into different files and save

class VoteDataRow
    attr_accessor :date, :voteno, :bill, :vote, :mpid, :first_name, :surname, :party, :url

    def initialize(row)
        @date = Date.parse(row['date'])
        @voteno = row['voteno'].to_i
        @bill = row['bill']
        @vote = row['vote']
        @mpid = row['mpid'].to_i
        @first_name = row['first_name']
        @surname = row['surname']
        @party = row['party']
        @url = row['url']
    end

    def to_a
        [@date, @voteno, @bill, @vote, @mpid, @first_name, @surname, @party, @url]
    end
    def self.headers
        ['date', 'voteno', 'bill', 'vote', 'mpid', 'first_name', 'surname', 'party', 'url']
    end
end

class VoteDataTable
    attr_accessor :vote_records
    def initialize(file='vote_data.csv')
        read(file)
    end
    def read(file='vote_data.csv')
        @vote_records = []
        CSV.foreach(file, :headers => true) do |r|
            @vote_records << VoteDataRow.new(r)
        end
    end

    # Returns an array of VoteDataRows for the given mpid
    def votes_for_mp(mpid)

    end

    # Returns a hash of votes for a given bill:
    # e.g. {'ayes'=> 25, 'noes'=> 4, .... }
    def votes_for_bill(voteno)

    end

    def write(file)
        CSV.open(file, 'wb') do |csv|
            csv << VoteDataRow.headers
            ## write the vote_records to the file here

        end
    end
end


