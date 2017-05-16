require 'serverspec'

# the serverspec os helper won't work here,
# because it needs the backend set to work
if Gem.win_platform?
  set :backend, :cmd
else
  set :backend, :exec
end
