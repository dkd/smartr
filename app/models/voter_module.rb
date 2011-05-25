module VoterModule
  
  def voted_on?(record)
    record.votes.where("user_id=?", id).present?
  end
  
  def up_voted?(record)
    record.votes.where("user_id=? and value=?", id, "1").present?
  end
  
  def down_voted?(record)
    record.votes.where("user_id=? and value=?", id, "-1").present?
  end

end