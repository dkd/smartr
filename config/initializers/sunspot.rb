require File.join(Rails.root, 'lib', 'sunspot', 'rails', 'adapters')

# Sunspot.session = Sunspot::Rails.build_session
Sunspot::Adapters::InstanceAdapter.register(Sunspot::Rails::Adapters::ActiveRecordInstanceAdapter, ActiveRecord::Base)
Sunspot::Adapters::DataAccessor.register(Sunspot::Rails::Adapters::ActiveRecordDataAccessor, ActiveRecord::Base)