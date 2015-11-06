include ::apt

apt::source { 'r-project':
  location => 'http://cran.r-project.org/bin/linux/ubuntu',
  repos    => '',
  release  => 'trusty/',
  include  => {
    src => false,
  },
  key      => {
    'id' => 'E084DAB9'
  },
  notify   => Exec['apt_update'],
}

package { [
            'curl',
            'git',
            'python',
            'python-rpy',
            'python-rpy-doc',
            'python-rpy2',
            'ruby-dev',
            'unzip',
            'vim',
          ]:
  ensure => installed,
}

package { [
            'librarian-puppet',
            'puppet-lint',
          ]:
  ensure   => present,
  provider => 'gem',
  require  => Package['ruby-dev'],
}

exec { 'apt-update':
  command => '/usr/bin/apt-get update',
  require => Apt::Source['r-project'],
}

package { [
            'r-base',
            'r-base-dev',
          ]:
  ensure  => present,
  require => Exec['apt-update'],
}

