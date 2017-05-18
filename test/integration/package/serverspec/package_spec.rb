require 'spec_helper'

describe command 'ruby --version' do
  its(:stdout) { is_expected.to include('ruby') }
end
