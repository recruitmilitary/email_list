require 'email_list'

describe EmailList do

  describe '.valid?' do
    it 'returns true for a single email address' do
      EmailList.valid?('foo@example.com').should be_true
    end

    it 'returns false for a blank string' do
      EmailList.valid?(' ').should be_false
    end

    it 'returns false for a bad email' do
      EmailList.valid?('foo').should be_false
    end

    it 'returns false when one email in a list is invalid' do
      EmailList.valid?('foo@example.com, foo@').should be_false
    end

    it 'returns true for a comma separated list of email addresses' do
      EmailList.valid?('foo@example.com,bar@example.com').should be_true
    end

    it 'returns true for a comma separated (with spaces) list of email addresses' do
      EmailList.valid?('foo@example.com, bar@example.com').should be_true
    end

    it 'returns true for a comma separated (with multiple spaces) list of email addresses' do
      EmailList.valid?('foo@example.com,  bar@example.com').should be_true
    end

    it 'returns true for a semi-colon separated list of email addresses' do
      EmailList.valid?('foo@example.com;bar@example.com').should be_true
    end

    it 'returns true for a semi-colon separated (with spaces) list of email addresses' do
      EmailList.valid?('foo@example.com; bar@example.com').should be_true
    end

    it 'returns true for a semi-colon separated (with multiple spaces) list of email addresses' do
      EmailList.valid?('foo@example.com;  bar@example.com').should be_true
    end
  end

  describe '.split' do
    it 'returns a one element array for a single email address' do
      EmailList.split('foo@example.org').should == ['foo@example.org']
    end

    it 'returns an array of email addresses for a comma separated list' do
      EmailList.split('foo@example.org,bar@example.org').should == ['foo@example.org', 'bar@example.org']
    end

    it 'returns an array of email addresses for a comma separated (with spaces) list' do
      EmailList.split('foo@example.org,  bar@example.org').should == ['foo@example.org', 'bar@example.org']
    end

    it 'returns an array of email addresses for a semi-colon separated list' do
      EmailList.split('foo@example.org;bar@example.org').should == ['foo@example.org', 'bar@example.org']
    end

    it 'returns an array of email addresses for a semi-colon separated (with spaces) list' do
      EmailList.split('foo@example.org;  bar@example.org').should == ['foo@example.org', 'bar@example.org']
    end
  end

  describe '#to_s' do
    it 'returns the original string' do
      string = 'foo@example.org, bar@example.org'
      email_list = EmailList.new(string)

      email_list.to_s.should == string
    end
  end

  it 'behaves like an enumerable' do
    email_list = EmailList.new('foo@example.org, bar@example.org')

    email_list.map.should == ['foo@example.org', 'bar@example.org']
  end

  it 'compares against other instances of EmailList' do
    email_list1 = EmailList.new('foo@example.org, bar@example.org')
    email_list2 = EmailList.new('bar@example.org, foo@example.org')

    email_list1.should == email_list2
    email_list2.should == email_list1
  end

  it 'compares against strings' do
    string = 'foo@example.org, bar@example.org'
    email_list = EmailList.new(string)

    email_list.should == string
  end

  it 'compares against arrays' do
    email_list = EmailList.new('foo@example.org, bar@example.org')

    email_list.should == ['foo@example.org', 'bar@example.org']
  end

  it 'allows the additional of arrays' do
    email_list = EmailList.new 'foo@example.org'

    (email_list + ['bar@example.org']).should == EmailList.new('foo@example.org, bar@example.org')
  end

  it 'returns an empty email list when given nil' do
    email_list = EmailList.new(nil)

    email_list.emails.should == []
  end

  it 'allows initialization with an array' do
    addresses = ['foo@example.org', 'bar@example.org']
    email_list = EmailList.new addresses

    email_list.should == addresses
  end

  it 'knows the size of the list' do
    email_list = EmailList.new('foo@example.org, bar@example.org')

    email_list.size.should == 2
  end
end
