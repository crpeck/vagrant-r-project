class {'apt':}

apt::source { 'r-project':
  location => 'http://cran.rstudio.com/bin/linux/ubuntu',
  repos    => '',
  release  => 'trusty/',
  include  => {
    src => false,
  },
  key      => {
    'id' => 'E084DAB9'
  },
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

package { [
            'r-base',
            'r-base-dev',
          ]:
  ensure  => present,
  require => Apt::Source['r-project'],
}
