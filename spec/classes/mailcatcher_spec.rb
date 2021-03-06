require 'spec_helper'

describe 'mailcatcher', :type => :class do
  context "As a Web Operations Engineer" do
    context 'When I install the mailcatcher base class on Ubuntu' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu'
      }
      end

      describe 'by default it' do
        it { should compile.with_all_deps }
        it { should contain_class('ruby') }
        it { should contain_package('sqlite3') }
        it { should contain_package('libsqlite3-dev') }
        it { should contain_package('mailcatcher').with({ 'provider' => 'gem'}) }
        it { should contain_user('mailcatcher') }
        it 'should contain a properly formatted start up configuration for upstart' do
          should contain_file('/etc/init/mailcatcher.conf').with_content(/exec\s+nohup\s+\/usr\/local\/bin\/mailcatcher\s+--http-ip\s+0\.0\.0\.0\s+--http-port\s+1080\s+--smtp-ip\s+0\.0\.0\.0\s+--smtp-port\s+1025\s+-f/)
        end
        it { should contain_file('/etc/init/mailcatcher.conf').with({ :notify => 'Class[Mailcatcher::Service]'})}
        it { should contain_file('/var/log/mailcatcher').with({
            :ensure  => 'directory',
            :owner   => 'mailcatcher',
            :group   => 'mailcatcher',
            :mode    => '0755',
            :require => 'User[mailcatcher]'
        })}
        it { should contain_service('mailcatcher').with({
            :ensure     => 'running',
            :provider   => 'upstart',
            :hasstatus  => true,
            :hasrestart => true,
            :require    => 'Class[Mailcatcher::Config]',
        })}

      end
    end

    context 'When I install the mailcatcher base class on Debian Wheezy' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'Debian',
          :lsbdistcodename => 'wheezy'
      }
      end

      describe 'by default it' do
          it { should compile.with_all_deps }
      end
    end

    context 'When I install the mailcatcher base class on Debian Jessie' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'Debian',
          :lsbdistcodename => 'jessie'
      }
      end

      describe 'by default it' do
          it { should compile.with_all_deps }
      end
    end

    context 'When I install the mailcatcher base class on LinuxMint' do
      let :facts do {
          :osfamily        => 'Debian',
          :operatingsystem => 'LinuxMint',
      }
      end

      describe 'by default it' do
          it { should compile.with_all_deps }
      end
    end

    context 'When I install the mailcatcher base class on Redhat 7' do
      let :facts do {
          :osfamily                   => 'Redhat',
          :operatingsystem            => 'Redhat',
          :operatingsystemmajrelease  => '7'
      }
      end

      describe 'by default it' do
        it { should compile.with_all_deps }
      end
    end
  end
end
