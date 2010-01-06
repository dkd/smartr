class Permission < ActiveRecord::Base
  has_and_belongs_to_many :user_groups
  
	def all_users
		User.find_by_sql <<-SQL
			select users.* 
			from users, user_groups_users, permissions_user_groups
			where users.id = user_groups_users.user_id 
			and user_groups_users.user_group_id = permissions_user_groups.user_group_id
			and permissions_user_groups.permission_id = #{self.id}
		SQL
  end
end
