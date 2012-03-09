module VotingModule

  def up_votes
    votes.where("value=1").count
  end

  def down_votes
    votes.where("value=-1").count
  end

end