require 'spec_helper'

describe Edit do
  it { should belong_to :editable }
  it { should belong_to :user }
  it { should validate_presence_of :body }
  it { should ensure_length_of :body }
end
