require 'spec_helper'

describe command '/usr/local/bin/ruby --version' do
  its(:stdout) { is_expected.to include('ruby 1.9.3') }
end
