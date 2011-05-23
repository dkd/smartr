module VotesHelper
  def count_votes(record)
    (record.votes.count == 0)? 0 : record.votes.inject(0) {|result, vote| result += vote.value }
  end
end