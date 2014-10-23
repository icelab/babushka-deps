dep "postgres fixed for yosemite" do
  met? {
    new_dirs = %w(pg_tblspc pg_twophase pg_stat_tmp)

    !"/usr/local/var/postgres".p.exists? || new_dirs.all? { |dir| "/usr/local/var/postgres/#{dir}".p.exists? }
  }

  meet {
    shell "mkdir -p /usr/local/var/postgres/{pg_tblspc,pg_twophase,pg_stat_tmp} && touch /usr/local/var/postgres/{pg_tblspc,pg_twophase,pg_stat_tmp}/.keep"
    shell "brew services stop postgresql; sleep 2; brew services start postgresql"
  }
end
